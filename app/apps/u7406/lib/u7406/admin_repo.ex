defmodule U7406.AdminRepo do
  alias U7406.Repo

  def all(query) do
    Repo.as_admin(fn ->
      Repo.all(query)
    end)
  end

  def one(query) do
    Repo.as_admin(fn ->
      Repo.one(query)
    end)
  end

  def one(query, opts) do
    Repo.as_admin(fn ->
      Repo.one(query, opts)
    end)
  end

  def insert(query) do
    Repo.as_admin(fn ->
      Repo.insert(query)
    end)
  end

  def update(query) do
    Repo.as_admin(fn ->
      Repo.update(query)
    end)
  end

  def delete(query) do
    Repo.as_admin(fn ->
      Repo.delete(query)
    end)
  end

  def transaction(fun_or_multi, opts) do
    Repo.transaction(fun_or_multi, opts)
  end

  def transaction(fun_or_multi) do
    Repo.transaction(fun_or_multi)
  end

  def rollback(value) do
    Repo.rollback(value)
  end
end
