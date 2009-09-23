module Praxidata
  module Import
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def import(import_record)
         # Try finding a previously imported record unless there's no primary key
         record = self.find_by_imported_id(import_record.id) unless import_record.id.nil?
         # Create a new one, otherwise; remember from where we imported
         record ||= self.new(:imported_id => import_record.id)

         # Do the actual import
         record.import(import_record)
         
         return record
      end
    end
  end
end