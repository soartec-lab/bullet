module Bullet
  module Registry
    class Association
      attr_reader :registry

      def initialize
        @registry = {}
      end

      def add( base, associations )
        @registry[base] ||= []
        @registry[base] << associations
        unique( @registry[base] )
      end

      def merge( base, associations )
        @registry.merge!( { base => associations } )
        unique( @registry[base] )
      end

      def similarly_associated( base, associations )
        @registry.select do |key, value|
          key.include?( base ) and value == associations
        end.collect( &:first ).flatten!
      end

      def [](base)
        @registry[base]
      end

      def delete( base )
        @registry.delete( base )
      end

      def select( *args, &block )
        @registry.select( *args, &block )
      end

      def each( &block ) 
        @registry.each( &block )
      end

      private
      def unique( array )
        array.flatten!
        array.uniq!
      end
    end
  end
end
