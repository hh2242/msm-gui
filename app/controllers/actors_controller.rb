class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert_actor
    name = params[:query_name]
    dob = params[:query_dob]
    bio = params[:query_bio]
    image = params[:query_image]

    @actor = Actor.new(name: name, dob: dob, bio: bio, image: image)

    if @actor.save
      redirect_to("/actors")
    else
      render :new
    end
  end

  def modify_actor
    id = params[:id]
    name = params[:query_name]
    dob = params[:query_dob]
    bio = params[:query_bio]
    image = params[:query_image]

    @actor = Actor.find(id.to_i)
    @actor.name = name
    @actor.dob = dob
    @actor.bio = bio
    @actor.image = image

    if @actor.save
      redirect_to("/actors/" + id)
    else
      render :new
    end
  end
end
