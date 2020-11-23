module ApplicationHelper


  def link_to_document(doc, field_or_opts = nil, opts = { counter: nil })
    label = case field_or_opts
            when NilClass
              index_presenter(doc).label document_show_link_field(doc), opts
            when Hash
              opts = field_or_opts
              index_presenter(doc).label document_show_link_field(doc), opts
            when Proc, Symbol
              Deprecation.warn(self, "passing a #{field_or_opts.class} to link_to_document is deprecated and will be removed in Blacklight 8")
              Deprecation.silence(Blacklight::IndexPresenter) do
                index_presenter(doc).label field_or_opts, opts
              end
            else # String
              field_or_opts
            end
    destination = doc['identifier_si'].html_safe
    link_to label, destination
  end


  def oai_thumbs(document,image_options)

    if document['hasFormat_teim'].nil?

      link = document['identifier_si']
      if link.include? "lcdl"
        thumb = link.gsub("http://lcdl.library.cofc.edu/lcdl/catalog/","http://fedora.library.cofc.edu:8080/fedora/objects/") + "/datastreams/THUMB1/content"
      elsif link.include? "encore"
        thumb = ""
      elsif link.include? "handle"
        thumb = ""
      elsif link.include? "statelibrary"
        thumb = ""
      else
        thumb = link.gsub("cdm\/ref","utils\/getthumbnail")
      end

    url = "<img src='#{thumb}'/>"
    return url.html_safe

  else

  link = document['hasFormat_teim'].join
  url = "<img src='#{link}'/>"
  return url.html_safe

  end

  end


end
