# t is the scope of the view / helpers.
# This will append it to a content_for section
# instead of directly in the page.
BHM::GoogleMaps.include_js_proc = proc do |t|
  t.content_for :extra_head, t.javascript_include_tag(t.google_maps_url(false), "gmap.js")
end
