include ActionView::Helpers::NumberHelper
module PrawnResumeHelper 
  class InvoicingAndReceipts
    include Prawn::View

    def document
      @my_prawn_doc ||= Prawn::Document.new(page_size: 'A4')
    end
  
    def initialize(type, user, data)
      font_size(22)
       
      @name = type
      @user = user
      @data = data
     	
      move_down 35
      text @data.info.name, :size => 35, :color => "808080"
      text @data.info.headline
      text @data.info.email
      move_down 15
      stroke_horizontal_rule
      move_down 10
      text "Summary", :size => 35, :color => "808080"
      move_down 15
      text @data.extra.raw_info.summary
      move_down 15
      stroke_horizontal_rule
      move_down 15
      text "Experience", :size => 35, :color => "808080"
      move_down 15
      text @data.info.headline
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
     	move_down 15
     	stroke_horizontal_rule
      move_down 15
      text "Education" , :size => 35, :color => "808080"
    end
  end
end