include ActionView::Helpers::NumberHelper
include ActionView::Helpers::UrlHelper
module PrawnResumeHelper 
  class InvoicingAndReceipts
    include Prawn::View

    def document
      @my_prawn_doc ||= Prawn::Document.new(page_size: 'A4')
    end
  
    def initialize(type, user, data)
      stroke_color "808080"
      font_size(18)
       
      @name = type
      @user = user
      @data = data
     	
      move_down 35
      text @data.info.name, :size => 25, :color => "808080"
      text @data.info.headline
      text @data.info.email
      move_down 15
      stroke_horizontal_rule
      move_down 10
      text "Summary", :size => 25, :color => "808080"
      move_down 15
      text @data.extra.raw_info.summary
      move_down 15
      stroke_horizontal_rule
      move_down 15
      text "Experience", :size => 25, :color => "808080"
      move_down 15
      text @data.info.headline
      if @data.extra.raw_info["positions"].present? and @data.extra.raw_info["positions"]["values"].present?
        @data.extra.raw_info["positions"]["values"].each do |pos|
        	@present = ""
        	pos.each do |p|
        		if p[0] == "isCurrent"
        			@present = "Present"
        		end
        		if p[0] == "startDate"
        			text Date::MONTHNAMES[p[1].month].to_s + " " + p[1].year.to_s + " - " + @present
        		end
        	end
        end
      end
     	move_down 15
     	# stroke_horizontal_rule
      # move_down 15
      # text "Education" , :size => 25, :color => "808080"
      move_down 15
      stroke_horizontal_rule
      move_down 15
      image "#{Rails.root}/app/assets/images/linkedin.png", width: 100, height: 20
    end
  end
end