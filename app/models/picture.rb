class Picture < ActiveRecord::Base
    belongs_to :dog

    has_attached_file :image,
        :styles => { :medium => "350x" },
        :path => ":rails_root/public/images/:id/:filename",
        :url  => "/images/:id/:filename"

    do_not_validate_attachment_file_type :image
end
