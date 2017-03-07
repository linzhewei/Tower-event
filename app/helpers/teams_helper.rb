module TeamsHelper
  def render_team_member_or_not(user, team)
    if current_user && user.is_member_of_team?(team)
      content_tag(:span, "团队成员", class:"label label-success pull-right")
    else
      content_tag(:span, "不是团队成员", class:"label label-warning pull-right")
    end
  end

  def render_join_or_quit_team(user, team)
    if current_user && user.is_member_of_team?(team)
      link_to "退出团队", quit_team_path(team), method: :post, class:"btn btn-xs btn-default"
    else
      link_to "加入团队", join_team_path(team), method: :post, class:"btn btn-xs btn-default"
    end
  end

  def render_all_team_members(user, team)
    if current_user && user.is_member_of_team?(team)
      link_to "所有成员", all_members_team_path(team), class:"btn btn-xs btn-primary pull-right"
    end
  end

  def render_team_name(user, team)
    if user.is_member_of_team?(team)
      link_to team.name, team_path(team)
    else
      team.name
    end
  end

  def render_project_title(user, project)
    if user.is_member_of_project?(project)
      link_to project.name, team_project_path(project.team, project)
    else
      project.name
    end
  end
end
