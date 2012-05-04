require 'attribute_normalizer'
ActiveRecord::Base.send :include, AttributeNormalizer
