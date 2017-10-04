class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content_length}
  validate  :picture_size

  default_scope ->{order created_at: :desc}
  # scope :load_feed, ->id{where user_id: id}
  scope :load_feed, ->(id, following_ids) do
    where "user_id IN (?) OR user_id = ?", following_ids, id
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > Settings.image.upload_micropost_size .megabytes
      errors.add :picture,
        I18n.t("micropost.flash.danger_image_upload_too_large_size",
          size: Settings.image.upload_micropost_size)
    end
  end
end
