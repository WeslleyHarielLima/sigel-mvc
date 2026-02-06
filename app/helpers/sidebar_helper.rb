module SidebarHelper
  def render_sidebar(user)
    return unless user

    if user.admin?
      render "shared/sidebar/sidebar"
    elsif user.gerenciador?
      render "shared/sidebar/sidebar_gerenciador"
    elsif user.vistoriador?
      render "shared/sidebar/sidebar_vistoriador"
    else
      render "shared/sidebar/sidebar"
    end
  end
end
