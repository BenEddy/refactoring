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

  def target_key
    if target_low?
      'target_low'
    elsif target_high?
      'target_high'
    else
      'target_general'
    end
  end

  def text_with_target
    key = "#{target_key}_applicant"

    if applicant_underdeveloped?
      if target_low?
        key << ((@applicant_score < @target_score) ? '_more' : '_less')
      end
      INSIGHTS["#{key}_underdeveloped_text".to_sym]
    elsif applicant_overdeveloped?
      if target_high?
        key << ((@applicant_score > @target_score) ? '_more' : '_less')
      end
      INSIGHTS["#{key}_overdeveloped_text".to_sym]
    end
  end

end
