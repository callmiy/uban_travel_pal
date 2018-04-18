defmodule Urban.Attachment do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)
  @storage Application.get_env(:urban, :arc_storage_dir)
  @file_name_prefix "__x__"

  def acl(:thumb, _), do: :public_read

  def validate({file, _}) do
    file_extension =
      file.file_name
      |> Path.extname()
      |> String.downcase()

    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:thumb, _) do
    {
      :convert,
      "-thumbnail 100x100^ -gravity center -extent 100x100 -format png",
      :png
    }
  end

  # def filename(version, {file, %{inserted_at: nil, updated_at: nil} = scope}) do
  #   now = Timex.now()

  #   scope = %{
  #     scope
  #     | inserted_at: now,
  #       updated_at: now
  #   }

  #   filename(version, {file, scope})
  # end

  def filename(version, {file, %{inserted_at: inserted_at} = _scope}) do
    file_name =
      file.file_name
      |> Path.basename(Path.extname(file.file_name))

    inserted_at = Timex.to_gregorian_seconds(inserted_at)
    id_version = "#{@file_name_prefix}_#{inserted_at}_#{version}_"

    if String.starts_with?(file_name, id_version) do
      file_name
    else
      "#{id_version}#{file_name}"
    end
  end

  def storage_dir(_, {_file, %{__meta__: %{source: {_, table}}}}) do
    "#{@storage}/#{table}"
  end

  def default_url(:thumb) do
    "/not-found.jpeg/100x100"
  end
end
