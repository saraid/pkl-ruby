module Pkl
  module Refinements
    refine String do
      def underscorize = gsub(/([A-Z])/) { "_#{_1.downcase}" }
    end

    refine Symbol do
      def underscorize = to_s.underscorize
    end
  end
end
