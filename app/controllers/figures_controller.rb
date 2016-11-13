require "pry"
class FiguresController < ApplicationController


  get "/figures" do
    erb :"figures/index"
  end

  get "/figures/new" do
    erb :"figures/new"
  end

  post "/figures" do
    #binding.pry
    @figure = Figure.create(params[:figure])

    params[:figure][:title_ids].each {|id| @figure.titles << Title.find(id.to_i) } if params[:figure][:title_ids]

    @figure.titles << Title.create(params[:title]) if !params[:title][:name].empty?

    params[:figure][:landmark_ids].each {|id| @figure.landmarks << Landmark.find(id.to_i)} if params[:figure][:landmark_ids]

    @figure.landmarks << Landmark.create(params[:landmark]) if !params[:landmark][:name].empty?

    @figure.save

  end

  get "/figures/:index" do
    @figure = Figure.find(params[:index])
    erb :"figures/show"
  end

  get "/figures/:index/edit" do
    @figure = Figure.find(params[:index])
    erb :"figures/edit"
  end

  post "/figures/:index/edit" do
    @figure = Figure.find_by(params[:index])
    @figure.update(name)
    #binding.pry
    redirect "/figures/#{@figure.id}"
  end


end
