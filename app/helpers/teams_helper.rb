module TeamsHelper
  def render_team_member_or_not(user, team)
    if current_user && user.is_member_of?(team)
      content_tag(:span, "团队成员", class:"label label-success pull-right")
    else
      content_tag(:span, "不是团队成员", class:"label label-warning pull-right")
    end
  end

  def render_join_or_quit_team(user, team)
    if current_user && user.is_member_of?(team)
      link_to "退出团队", quit_team_path(team), method: :post, class:"btn btn-xs btn-default"
    else
      link_to "加入团队", join_team_path(team), method: :post, class:"btn btn-xs btn-default"
    end
  end

  def render_all_team_members(user, team)
    if current_user && user.is_member_of?(team)
      link_to "所有成员", all_members_team_path(team), class:"btn btn-xs btn-primary pull-right"
    end
  end
end
