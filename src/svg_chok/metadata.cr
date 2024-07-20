struct SvgChok::Metadata
  getter width : Float64
  getter height : Float64

  def initialize(@svg : String)
    @width, @height = parse_doc(@svg) || {595.0, 842.0}
  end

  def ratio
    @width / @height
  end

  private def parse_doc(svg)
    return unless svg = svg.match(/<svg[^>]*>/)

    node = XML.parse(svg[0]).first_element_child.as(XML::Node)
    parse_dimensions(node)
  end

  private def parse_dimensions(doc)
    if (width = doc["width"]?) && (height = doc["height"]?)
      {unitless(width).to_f, unitless(height).to_f}
    elsif viewbox = doc["viewBox"]?.try(&.split(" "))
      {viewbox[2].to_f, viewbox[3].to_f}
    end
  end

  private def unitless(value)
    value.gsub(/[^\d\.]+/, "")
  end
end
