defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings that represents playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # use list comprehension (multiple)
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Takes your existing deck of cards and shuffles the order of the cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card.

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  @doc """
    Takes a deck of cards and returns the number of cards equals to the `hand_size`
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves your deck of cards to a local file.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary);
  end

  @doc """
    Loads your deck of cards from a local file and returns an array of cards.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} ->  :erlang.binary_to_term(binary)
      {:error, _reason} -> "The file does not exist"
      _ -> "There was an error with the request"
    end
  end

  @doc """
    Creates a deck, shuffles it, and then deals the `hand_size` of cards.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
