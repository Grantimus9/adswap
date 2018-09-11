defmodule Adswap.Auth do
  def authorize(_action, _user) do
    {:error, "Prohibited action - no rule allowed this action."}
  end
end
