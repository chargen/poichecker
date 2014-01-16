# encoding: UTF-8
ActiveAdmin.register Candidate do

  belongs_to :place

  actions :all, :except => [:destroy, :new, :update, :index, :edit, :index]

  controller do
    private

    def resource
      Candidate.find(params[:id])
    end

  end

  show title: proc{ parent.name rescue 'Orte' } do
    panel "Vergleich" do
      form_for :Candidate, :url => '/' do |form|
        attributes_table_for [place, resource, Candidate.new] do
          %w{name street housenumber postcode city lat lon wheelchair}.each do |f|
            row f do |n|
              if n.id.nil?
                form.text_field f
              else
                span n.send(f)
              end
            end
          end
          row :action do |n|
            if n.id.nil?
              form.submit
            end
          end
        end
      end
    end
  end

end