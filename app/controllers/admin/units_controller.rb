module Admin
  class UnitsController < Admin::ApplicationController
    include ::PublishableController

    def default_sorting_attribute
      :order
    end

    def default_sorting_direction
      :asc
    end

    def destroy_unit_guide
      requested_resource = Unit.find(params[:unit_id])
      requested_resource.unit_guide.purge
      redirect_back(fallback_location: requested_resource)
    end

    def destroy_learning_graph
      requested_resource = Unit.find(params[:unit_id])
      learning_graph = requested_resource.learning_graphs.find(params[:attachment_id])
      learning_graph.purge
      redirect_back(fallback_location: requested_resource)
    end

    def destroy_rubric
      requested_resource = Unit.find(params[:unit_id])
      rubric = requested_resource.rubrics.find(params[:attachment_id])
      rubric.purge
      redirect_back(fallback_location: requested_resource)
    end

    def destroy_summative_assessment
      requested_resource = Unit.find(params[:unit_id])
      summative_assessment = requested_resource.summative_assessments.find(params[:attachment_id])
      summative_assessment.purge
      redirect_back(fallback_location: requested_resource)
    end

    def destroy_summative_answer
      requested_resource = Unit.find(params[:unit_id])
      summative_answer = requested_resource.summative_answers.find(params[:attachment_id])
      summative_answer.purge
      redirect_back(fallback_location: requested_resource)
    end

    def valid_action?(name, resource = resource_class)
      return false if resource.to_s == 'national_curriculum_statement' && name.to_s == 'destroy'
      return false if resource.to_s == 'connected_world_strand' && name.to_s == 'destroy'

      super
    end

    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
