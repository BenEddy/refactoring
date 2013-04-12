class InsightLookup
  INSIGHTS = {
    :applicant_overdeveloped_text                  => 'applicant overdeveloped text',
    :applicant_underdeveloped_text                 => 'applicant underdeveloped text',
    :target_general_applicant_overdeveloped_text   => 'target general applicant overdeveloped text',
    :target_general_applicant_underdeveloped_text  => 'target general applicant underdeveloped text',
    :target_high_applicant_more_overdeveloped_text => 'target high applicant more overdeveloped text',
    :target_high_applicant_less_overdeveloped_text => 'target high applicant less overdeveloped text',
    :target_high_applicant_underdeveloped_text     => 'target high applicant underdeveloped text',
    :target_low_applicant_more_underdeveloped_text => 'target low applicant more underdeveloped text',
    :target_low_applicant_less_underdeveloped_text => 'target low applicant less underdeveloped text',
    :target_low_applicant_overdeveloped_text       => 'target low applicant overdeveloped text',
  }

  def initialize(applicant_score, target_score)
    @applicant_score = applicant_score
    @target_score = target_score
  end

  def analyze
    @target_score.nil? ? text_without_target : text_with_target
  end

  private

  def applicant_underdeveloped?
    @applicant_score < 40
  end

  def applicant_overdeveloped?
    @applicant_score > 60
  end

  def target_low?
    @target_score < 40
  end

  def target_high?
    @target_score > 60
  end

  def text_without_target
   applicant_overdeveloped? ? INSIGHTS[:applicant_overdeveloped_text] : INSIGHTS[:applicant_underdeveloped_text]
  end

  def text_with_target
    if applicant_underdeveloped?
      if target_low?
        if @applicant_score < @target_score
          INSIGHTS[:target_low_applicant_more_underdeveloped_text]
        else
          INSIGHTS[:target_low_applicant_less_underdeveloped_text]
        end
      elsif target_high?
        INSIGHTS[:target_high_applicant_underdeveloped_text]
      else
        INSIGHTS[:target_general_applicant_underdeveloped_text]
      end
    elsif applicant_overdeveloped?
      if target_low?
        INSIGHTS[:target_low_applicant_overdeveloped_text]
      elsif target_high?
        if @applicant_score > @target_score
          INSIGHTS[:target_high_applicant_more_overdeveloped_text]
        else
          INSIGHTS[:target_high_applicant_less_overdeveloped_text]
        end
      else
        INSIGHTS[:target_general_applicant_overdeveloped_text]
      end
    end
  end
end
