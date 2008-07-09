module CommentsHelper
  def render_comment(comment)
    content = ''
    editable = comment.editable_by?(User.current)
    links = []
    unless comment.comments.blank?
      links << link_to_in_place_comment_editor(image_tag('edit.png'), "comment-#{comment.id}-text", 
                                               { :controller => 'comments', :action => 'edit', :id => comment },
                                                 :title => l(:button_edit)) if editable
    end
    content << content_tag('div', links.join(' '), :class => 'contextual') unless links.empty?
    content << textilizable(comment, :comments)
    content_tag('div', content, :id => "comment-#{comment.id}-text", :class => (editable ? 'wiki editable' : 'wiki'))
  end
  
  def link_to_in_place_comment_editor(text, field_id, url, options={})
    onclick = "new Ajax.Request('#{url_for(url)}', {asynchronous:true, evalScripts:true, method:'get'}); return false;"
    link_to text, '#', options.merge(:onclick => onclick)
  end
end