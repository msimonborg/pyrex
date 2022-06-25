defmodule PYREx.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :string, autogenerate: false}
      @foreign_key_type :string
      @derive {Phoenix.Param, key: :id}
    end
  end
end
