class ExaminationSque
  @queue = "examination_sque"

  def self.perform(exam_id, paper_id, feedback_id, answers)
    exam = Examination.find(exam_id)
    exam.finish_paper(paper_id, feedback_id, answers)
  end
end
