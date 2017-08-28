module Viewpoint::EWS::Types

  # This represents a Contact object in the Exchange data store
  # @see https://msdn.microsoft.com/en-us/library/office/aa581315(v=exchg.150).aspx MSDN docs
  class Contact
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    CONTACT_KEY_PATHS = {
      culture:              [:culture, :text],
      initials:             [:initials],
      surname:              [:surname, :text],
      given_name:           [:given_name, :text],
      display_name:         [:display_name, :text],
      email_addresses:      [:email_addresses, :elems],
      physical_addresses:   [:physical_addresses, :elems],
      phone_numbers:        [:phone_numbers, :elems],
      assistant_name:       [:assistant_name],
      company_name:         [:company_name, :text],
      contact_source:       [:contact_source, :text],
      department:           [:department, :text],
      job_title:            [:job_title, :text],
      manager:              [:manager, :text],
      office_location:      [:office_location, :text]
    }

    CONTACT_KEY_TYPES = {}
    CONTACT_KEY_ALIAS = {}

    def initialize(ews, contact)
      @ews = ews
      @ews_item = contact
      simplify!
    end

    private

    def simplify!
      @ews_item = @ews_item.inject({}){|m,o|
        m[o.keys.first] = o.values.first[:text] || o.values.first[:elems];
        m
      }
    end

    def key_paths
      @key_paths ||= super.merge(CONTACT_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(CONTACT_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(CONTACT_KEY_ALIAS)
    end
  end
end
