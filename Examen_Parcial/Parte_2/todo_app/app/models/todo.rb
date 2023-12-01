class Todo < ApplicationRecord
    validates :description, presence: true
    validates :due_date, presence: true
  
    def tarea_vencida?
      due_date.present? && due_date < Date.today
    end
end
