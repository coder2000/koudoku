module Koudoku
  module ApplicationHelper

    def plan_price(plan)
      "#{number_to_currency(plan.price)}/#{plan_interval(plan)}"
    end

    def plan_interval(plan)
      interval = %w(month year week 6-month 3-month).include?(plan.interval) ? plan.interval.delete('-') : 'month'
      I18n.t("koudoku.plan_intervals.#{interval}")
    end
    
    def markdown(text)
      options = {
        filter_html:     true,
        hard_wrap:       true, 
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true, 
        fenced_code_blocks: true
      }

      extensions = {
        autolink:           true,
        superscript:        true,
        disable_indented_code_blocks: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      markdown.render(text).html_safe
    end

    # returns TRUE if the controller belongs to Koudoku
    # false in all other cases, for convenience when executing filters 
    # in the main application
    def koudoku_controller?
      is_a? Koudoku::ApplicationController
    end
  end
end
