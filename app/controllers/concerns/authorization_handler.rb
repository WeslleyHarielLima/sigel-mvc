module AuthorizationHandler
  extend ActiveSupport::Concern

  included do
    rescue_from CanCan::AccessDenied, with: :handle_access_denied
  end

  private

  def handle_access_denied(exception)
    # Coloca a mensagem no flash
    flash[:alert] = I18n.t("messages.not_authorized")
    # Redireciona de volta para a página anterior (ou root_path se não tiver referer)
    redirect_back(fallback_location: root_path)
  end
end
