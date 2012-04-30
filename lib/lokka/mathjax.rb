module Lokka
  module Mathjax
    def self.registered(app)
      app.get '/admin/plugins/mathjax' do
        haml :"plugin/lokka-mathjax/views/index", :layout => :"admin/layout"
      end

      app.put '/admin/plugins/mathjax' do
        Option.mathjax_use_dollar = params['mathjax_use_dollar']
        flash[:notice] = 'Updated.'
        redirect '/admin/plugins/mathjax'
      end

      app.before do
        use_dollar = Option.mathjax_use_dollar
        mathjax_header = ''
        if !use_dollar.blank?
          mathjax_header += '<script type="text/x-mathjax-config">'
          mathjax_header += "  MathJax.Hub.Config({ tex2jax: { inlineMath: [['$','$'], [\"\\\\(\",\"\\\\)\"]] } });"
          mathjax_header += "</script>"
        end
        mathjax_header += '<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML">'
        mathjax_header += "</script>"
        if !use_dollar.blank?
          mathjax_header += '<meta http-equiv="X-UA-Compatible" CONTENT="IE=EmulateIE7" />'
        end
        content_for :header do
          mathjax_header
        end
      end
    end
  end
end
