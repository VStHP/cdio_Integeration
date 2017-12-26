class AddAvatarBannerToCourseSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :banner, :string
    add_column :courses, :avatar, :string
    add_column :subjects, :avatar, :string
  end
end
