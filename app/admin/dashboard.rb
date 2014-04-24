# encoding: UTF-8
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column id: "checks" do
        panel "Deine letzten Checks" do
          ul do
            current_admin_user.matched_places.each do |place|
              li do
                link_to place.name, admin_place_path(place.data_set_id, place)
              end
            end
          end
        end
      end
      column id: "comments" do
        panel "Neuste Kommentare" do
          ul do
            render partial: 'active_admin/comments/comment', collection: ActiveAdmin::Comment.all
          end
          link_to "All Kommentare", admin_comments_path
        end
      end
    end
  end # content
end
