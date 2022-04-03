defmodule Cards do
  @moduledoc """
    Provies creating and handling a deck of cards
  """
  @doc """
    Returns list of strings representing deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines a deck contains given card


  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides deck into a hand and the remainder of the deck
    The `hand size` argument indicates the how many cards should be in hand


  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _restofthedeck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} ->
        :erlang.binary_to_term(binary)

      {:error, _reason} ->
        "No file"
    end
  end

  def create_hand(hand_size) do
    {hand, _deck} =
      Cards.create_deck()
      |> Cards.shuffle()
      |> Cards.deal(hand_size)

    hand
  end
end
