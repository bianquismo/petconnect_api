class PetShopsController < ApplicationController
  before_action :set_pet_shop, only: [:show, :update, :destroy]

  def index
    @pet_shops = PetShop.all
    render json: @pet_shops.as_json(methods: :image_url)
  end

  def show
    render json: @pet_shop.as_json(methods: :image_url)
  end

  def create
    @pet_shop = PetShop.new(pet_shop_params)
    if params[:pet_shop][:image].present?
      @pet_shop.image.attach(params[:pet_shop][:image])
    end

    if @pet_shop.save
      render json: @pet_shop.as_json(methods: :image_url), status: :created
    else
      render json: @pet_shop.errors, status: :unprocessable_entity
    end
  end

  def update
    if @pet_shop.update(pet_shop_params)
      if params[:pet_shop][:image].present?
        @pet_shop.image.attach(params[:pet_shop][:image])
      end
      render json: @pet_shop.as_json(methods: :image_url)
    else
      render json: @pet_shop.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pet_shop.destroy
    head :no_content
  end

  private

  def set_pet_shop
    @pet_shop = PetShop.find(params[:id])
  end

  def pet_shop_params
    params.require(:pet_shop).permit(:name, :address, :open_hours, :phone_number, :rating, :image)
  end
end

class PetShop < ApplicationRecord
  has_one_attached :image

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
