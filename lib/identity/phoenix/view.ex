if Code.ensure_loaded?(Phoenix.View) do
  defmodule Identity.Phoenix.View do
    @moduledoc false
    @template_root :code.priv_dir(:identity) |> Path.join("templates")
    use Phoenix.View, root: @template_root, namespace: Identity.Phoenix
    use Phoenix.HTML
    import Phoenix.LiveView.Helpers

    @doc """
    Provides easy routing within Identity-provided views.
    """
    @spec routes(Plug.Conn.t()) :: module
    def routes(conn) do
      Module.concat(Phoenix.Controller.router_module(conn), Helpers)
    end

    @doc """
    Generates tag for inlined form input errors.
    """
    def error_tag(form, field) do
      Enum.map(Keyword.get_values(form.errors, field), fn error ->
        content_tag(:span, translate_error(error),
          class: "invalid-feedback",
          phx_feedback_for: input_id(form, field)
        )
      end)
    end

    @doc """
    Translates an error message.
    """
    def translate_error({msg, opts}) do
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
      end)
    end
  end
end
