defmodule IdenticonTest do
  use ExUnit.Case

  test "when hash should generate struct" do
    identicon = Identicon.hash_input("fakeezz")
    assert identicon.hex
    refute identicon.color
  end

  test "when pick color should get first elements to be a color" do
    color_expected = {3, 247, 89}

    identicon =
      Identicon.hash_input("fakeezz")
      |> Identicon.pick_color

    assert color_expected == identicon.color
  end

  test "when build a grid should revert first and second position" do
    row_expected = [{3, 0}, {247, 1}, {89, 2}, {247, 3}, {3, 4}]
    identicon =
      Identicon.hash_input("fakeezz")
      |> Identicon.build_grid

    [r1, r2, r3, r4, r5 | _rest] = identicon.grid

    assert row_expected == [r1, r2, r3, r4, r5]
  end

  test "filter only odd squares when generate a grid" do
    row_expected = [{24, 5}, {72, 7}, {24, 9}, {46, 10}, {72, 11}]
    identicon =
      Identicon.hash_input("fakeezz")
      |> Identicon.build_grid
      |> Identicon.filter_odd_squares

    [r1, r2, r3, r4, r5 | _rest] = identicon.grid
    assert row_expected == [r1, r2, r3, r4, r5]
  end

  test "transform grid into a pixel_map" do
    identicon =
      Identicon.hash_input("fakeezz")
      |> Identicon.build_grid
      |> Identicon.filter_odd_squares

    refute identicon.pixel_map

    identicon =
      identicon
      |> Identicon.build_pixel_map

    assert identicon.pixel_map

  end
end
