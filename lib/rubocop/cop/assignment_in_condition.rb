# encoding: utf-8

module Rubocop
  module Cop
    ASGN_NODES = [:lvasgn, :ivasgn, :cvasgn, :gvasgn, :casgn]
    MSG = 'Assignment in condition detected. You probably wanted to use ==.'

    class AssignmentInCondition < Cop
      def on_if(node)
        check(node)
        super
      end

      def on_while(node)
        check(node)
        super
      end

      def on_until(node)
        check(node)
        super
      end

      private

      def check(node)
        condition, = *node

        on_node(ASGN_NODES , condition) do |asgn_node|
          add_offence(:warning, asgn_node.loc.operator, MSG)
        end
      end
    end
  end
end
