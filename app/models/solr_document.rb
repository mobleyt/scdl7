# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include BlacklightOaiProvider::SolrDocument

      # The following shows how to setup this blacklight document to display marc documents
  extension_parameters[:marc_source_field] = :marc_ss
  extension_parameters[:marc_format_type] = :marcxml
  use_extension( Blacklight::Solr::Document::Marc) do |document|
    document.key?( SolrDocument.extension_parameters[:marc_source_field] )
  end
  
field_semantics.merge!(
                         :title => "title_teim",
                         :creator => "creator_teim",
                         :date => "date_teim",
                         :description => "description_teim",
                         :extent => "extent_teim",
                         :medium => "medium_teim",
                         :identifier => "identifier_si",
                         :language => "language_sim",
                         :contributor => "contributor_teim",
                         :spatial => "spatial_teim",
                         :source => "source_teim",
                         :rights => "rights_teim",
                         :subject => "subject_teim",
                         :type => "type_teim",
                         :publisher => "publisher_teim",
                         :format => "format_teim",
                         :hasFormat => "hasFormat_sim",
                         :isPartOf => "relation_sim",
                         :rightsHolder => "rightsHolder_sim",
                         :accessRights => "accessRights_sim"
                         )



  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)
end
