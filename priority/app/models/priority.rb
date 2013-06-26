class Priority < ActiveRecord::Base

  unloadable

  attr_accessible :enabled, :field1, :field2, :field3, :weight1, :weight2, :weight3,
                  :normal_min, :normal_max, :high_min, :high_max, :urgent_min, :urgent_max, :project_id

  has_one :project

  validates :weight1, :weight2, :weight3, :normal_min, :normal_max, :high_min, :high_max, :urgent_min, :urgent_max,
            :project_id, presence: true, numericality: true

  validates_presence_of :field1, :field2, :field3

  before_save :update_issues_priorities

  def calculate_issue_priority(issue)
    if enabled? && !issue.closed?
      sum = issue.field1 * weight1 + issue.field2 * weight2 + issue.field3 * weight3
      case
        when sum < normal_min
          IssuePriority.find_by_position(1)
        when sum.in?(normal_min..normal_max)
          IssuePriority.find_by_position(2)
        when sum.in?(high_min..high_max)
          IssuePriority.find_by_position(3)
        when sum.in?(urgent_min..urgent_max)
          IssuePriority.find_by_position(4)
        when sum > urgent_max
          IssuePriority.find_by_position(5)
        else
          issue.priority
      end
    end
  end

  private

  def update_issues_priorities
    if enabled? && fields_changed?
      p = Project.find_by_id(project_id)
      issues = p ? p.issues.to_a : []
      issues.each do |i|
        i.update_column(:priority_id, calculate_issue_priority(i).id) if !i.closed?
      end
    end
  end

  def fields_changed?
    (%w(weight1 weight2 weight3 normal_min normal_max high_min high_max urgent_min urgent_max) & changed).any?
  end

end