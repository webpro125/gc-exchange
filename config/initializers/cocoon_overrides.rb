module Cocoon
  module ViewHelpers
    def create_object_on_association(f, association, instance, force_non_association_create)
      if instance.class.name == 'Mongoid::Relations::Metadata' || force_non_association_create
        create_object_with_conditions(instance)
      else
        assoc_obj = nil

        # assume ActiveRecord or compatible
        if instance.collection?
          assoc_obj = get_object(f).send(association).build
          f.object.model.send(association).delete(assoc_obj)
        else
          assoc_obj = get_object(f).send("build_#{association}")
          get_object(f).send(association).delete
        end

        assoc_obj = assoc_obj.dup if assoc_obj.frozen?

        assoc_obj
      end
    end

    def link_to_remove_association(*args, &block)
      if block_given?
        f            = args.first
        html_options = args.second || {}
        name         = capture(&block)
        link_to_remove_association(name, f, html_options)
      else
        name, f, html_options = args[0], args[1], args[2] || {}

        is_dynamic = get_object(f).new_record?

        html_options[:class] = [html_options[:class],
                                build_classes(is_dynamic, f)].compact.join(' ')

        wrapper_class = html_options.delete(:wrapper_class)
        html_options[:'data-wrapper-class'] = wrapper_class if wrapper_class.present?

        hidden_field_tag("#{f.object_name}[_destroy]",
                         get_object(f)._destroy) + link_to(name, '#', html_options)
      end
    end

    private

    def get_object(f)
      f.object.try(:model) || f.object
    end

    def build_classes(is_dynamic, f)
      classes = []
      classes << 'remove_fields'
      classes << (is_dynamic ? 'dynamic' : 'existing')
      classes << 'destroyed' if get_object(f).marked_for_destruction?
      classes.join(' ')
    end
  end
end
