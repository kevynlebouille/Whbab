class MergeParentAndDependUnitOption < ActiveRecord::Migration
  def up
    UnitOption.where("depend_id IS NOT NULL").each do |unit_option|
      unit_option.parent = unit_option.depend
      unit_option.depend = nil
      unit_option.save
      say "UnitOption \##{unit_option.id} updated !"
    end

    UnitOption.only_parents.each do |child|
      child.children.each_with_index do |child, index|
        child.position = index + 1
        child.save
        say "- UnitOption \##{child.id} reposition !"

        child.children.each_with_index do |child, index|
          child.position = index + 1
          child.save
          say "-- UnitOption \##{child.id} reposition !"

          child.children.each_with_index do |child, index|
            child.position = index + 1
            child.save
            say "--- UnitOption \##{child.id} reposition !"
          end
        end
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
