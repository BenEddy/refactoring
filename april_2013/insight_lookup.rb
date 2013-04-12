class InsightLookup
  INSIGHTS = {
    :overdeveloped           => 'applicant overdeveloped text',
    :underdeveloped          => 'applicant underdeveloped text',
    :general_overdeveloped   => 'target general applicant overdeveloped text',
    :general_underdeveloped  => 'target general applicant underdeveloped text',
    :high_more_overdeveloped => 'target high applicant more overdeveloped text',
    :high_less_overdeveloped => 'target high applicant less overdeveloped text',
    :high_underdeveloped     => 'target high applicant underdeveloped text',
    :low_more_underdeveloped => 'target low applicant more underdeveloped text',
    :low_less_underdeveloped => 'target low applicant less underdeveloped text',
    :low_overdeveloped       => 'target low applicant overdeveloped text',
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

  def applicant_in_range?
    @applicant_score >= 40 && @applicant_score <= 60
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
   applicant_overdeveloped? ? INSIGHTS[:overdeveloped] : INSIGHTS[:underdeveloped]
  end

  def target_key
    if target_low?
      'low'
    elsif target_high?
      'high'
    else
      'general'
    end
  end

  def comparison_level(in_range, compare)
    (compare ? 'more' : 'less') if in_range
  end

  def text_with_target
    keys = []

    keys << target_key

    if applicant_in_range?
      return nil
    elsif applicant_underdeveloped?
      keys << comparison_level(target_low?, @applicant_score < @target_score)
      keys << 'underdeveloped'
    elsif applicant_overdeveloped?
      keys << comparison_level(target_high?, @applicant_score > @target_score)
      keys << 'overdeveloped'
    end

    INSIGHTS[keys.compact.join('_').to_sym]
  end

end
