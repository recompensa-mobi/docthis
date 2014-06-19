# Customer Redcarpet rendered which uses pygments to decorate code blocks
class Docthis::Renderer < Redcarpet::Render::HTML

  # Process block codes with pygments
  #
  # Params:
  #   * code: Code block to pygmentize.
  #   * language: Language of the code block to pygmentize.
  #
  # Returns:
  #   The pygmentized HTML for the given code and language.
  def block_code(code, language)
    Pygmentize.process(code, language)
  end
end
