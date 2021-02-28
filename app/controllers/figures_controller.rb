class FiguresController < ApplicationController 

  get '/figures' do  #read - shows all figures 
    @figures = Figure.all 
    erb :'/figures/index'
  end

  get '/figures/new' do  #read - shows new figures and titles 
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do  #create - shows new page of landmark  
      @figures = Figure.create(params['figure'])
    unless params[:landmark][:name].empty?
      @figures.landmarks << Landmark.create(params[:landmark])
    end
    unless params[:title][:name].empty?
      @figures.titles << Title.create(params[:title])
    end
    @figures.save
    redirect to "/figures/#{@figures.id}"
  end 

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do  #update - shows page where you actually edit figures by id 
    @figures = Figure.find_by_id(params[:id])
      @figures.update(params[:figure])
      unless params[:title][:name].empty?
        @figures.titles << Title.create(params[:title])
      end
      unless params[:landmark][:name].empty?
        @figures.landmarks << Landmark.create(params[:landmark])
      end
      @figures.save
      redirect to "/figures/#{@figures.id}"
  end
  get '/figures/:id' do
    @figures = Figure.find(params[:id])
    erb :'figures/show'
  end
end

