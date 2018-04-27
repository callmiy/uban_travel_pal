defmodule UrbanWeb.ValidationController do
  use UrbanWeb, :controller

  @museum "Museum Tours"
  @guided_tours "Guided tours"
  @theme_tours "Theme based tours"
  @exploring "Exploring"
  @local_bars "Visit local bars"
  @cuisine "Try local cuisine"
  @nite_life "Explore night life"

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end

  def validate_activities(conn, %{"activities" => %{"a" => a, "d" => d}}) do
    render(conn, "validate.json", response: %{"a" => a, "d" => d})
  end

  def get_itineraries(conn, %{"a" => a, "d" => d, "initial" => "initial"}) do
    its =
      get_itinerary(a, d)
      |> get_itinerary()

    it = List.first(its)

    render(conn, "validate.json", response: %{itinerary: it, next_index: 1})
  end

  # we have already fetched last itinerary
  def get_itineraries(conn, %{"next_index" => "empty"}) do
    render(conn, "validate.json", response: %{itinerary: nil})
  end

  def get_itineraries(conn, %{"a" => a, "d" => d, "next_index" => index}) do
    its =
      get_itinerary(a, d)
      |> get_itinerary()

    index = String.to_integer(index)

    {next_index, it} =
      if index == length(its) - 1 do
        {"empty", List.last(its)}
      else
        {index + 1, Enum.at(its, index)}
      end

    render(
      conn,
      "validate.json",
      response: %{itinerary: it, next_index: next_index}
    )
  end

  def get_itinerary(@museum, @local_bars) do
    [
      %{
        name: "Pergamon Museum",
        address: "Bodestraße, Mitte",
        fee: "€12",
        url: "https://www.smb.museum/en/museums-institutions/pergamonmuseum/home.html"
      },
      %{
        name: "Topography of Terror",
        address: "Niederkirchnerstraße 8, Kreuzberg 10963",
        fee: "Free",
        byline: "And maybe take a famous insider walk in Berlin",
        url:
          "https://www.likealocalguide.com/berlin/tours/the-famous-insider-walk-in-berlin?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Einstein",
        address: "Kurfürstenstraße 58 10785 Berlin",
        byline: "Check for breakfast",
        url: "https://www.cafeeinstein.com/menu/"
      },
      %{
        name: "Café Pförtner",
        address: "Uferstr. 8, 13357 Berlin, Deutschland Berlin",
        byline: "Could be a good idea to join the lunch",
        url: "pfoertner.co"
      },
      %{
        name: "Crackers",
        address: "Friedrichstr. 158 (Unter den Linden), 10117 Berlin, Deutschland Berlin",
        byline: "Walk around Berlin center and then enjoy the dinner",
        url: "www.crackersberlin.com"
      },
      %{
        name: "Monkey Bar",
        address: "Budapester Str. 40, 10787 Berlin",
        byline: "After cool dinner feel free to check the drinks",
        url: "https://www.25hours-hotels.com/restaurants-bars/berlin/monkey-bar"
      },
      %{
        name: "Club der Visionäre",
        address: "Am Flutgraben 1 12435 Berlin",
        url: "https://www.facebook.com/ClubderVisionaere/?rf=222026867916166"
      }
    ]
  end

  def get_itinerary(@museum, @cuisine) do
    [
      %{
        name: "Stasi Museum",
        address: "Ruschestraße 103, Haus 1, Lichtenberg 10365",
        fee: "€6",
        byline: "Get excited",
        url: "http://www.stasimuseum.de/en/enindex.htm"
      },
      %{
        name: "DDR Museum",
        address: "Karl-Liebknecht-Str. 1, Mitte 10178",
        fee: "€9.50",
        byline: "Or maybe",
        url: "https://www.ddr-museum.de/de"
      },
      %{
        name: "Berlin walking tour",
        address: "",
        fee: "€12",
        byline: "The best would be to refresh your memories",
        url:
          "https://www.likealocalguide.com/berlin/tours/discover-berlin-walking-tour?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Michelberger Hotel",
        address: "Warschauer Straße 39 Berlin",
        fee: "",
        byline: "However if you want to get some energy first, get a nice breakfast",
        url: "http://www.michelbergerhotel.com/"
      },
      %{
        name: "Shiso Burger",
        address: "Auguststr.29c 10119 Berlin Mitte",
        fee: "",
        byline: "After the tour best to have lunch",
        url: "http://www.shisoburger.de"
      },
      %{
        name: "SECLUDED DINING",
        address: "13 Max-Beer-Straße, Berlin, 10119, Germany",
        fee: "",
        byline: "In case you want some special dinner visit",
        url: "http://www.shioriberlin.com/"
      },
      %{
        name: "Hashi Japanese Kitchen",
        address: "Rosenthaler Str. 63 Berlin",
        fee: "",
        byline: "Or dinner",
        url: "http://hashi-kitchen.de/en/"
      },
      %{
        name: "Katteschmaus (cafe bar club)",
        address: "KaterHolzig, Michaelkirchstr. 23, 10179 Berlin",
        fee: "",
        byline: "In case you are in the go out mood, visit",
        url: "http://www.katerholzig.de/restaurant/"
      }
    ]
  end

  def get_itinerary(@museum, @nite_life) do
    [
      %{
        name: "The Future Breakfast",
        address: "Briesestr. 9, Neukölln Berlin",
        fee: "",
        byline: "Start your day",
        url: "http://thefuturebreakfast.com/"
      },
      %{
        name: "Jewish Museum Berlin",
        address: "Lindenstraße 9-14, Kreuzberg 10969",
        fee: "€8",
        byline: "How about to learn some stuff",
        url: "https://www.jmberlin.de/en"
      },
      %{
        name: "Natural History Museum",
        address: "Invalidenstraße 43, Mitte 10115",
        fee: "€8",
        url: "https://www.visitberlin.de/en/museum-fur-naturkunde-museum-natural-history"
      },
      %{
        name: "Berlin behind the Wall (Cold war)",
        address: "",
        fee: "",
        byline: "May be a bit more history",
        url:
          "https://www.likealocalguide.com/berlin/tours/cold-war-berlin-behind-the-wall?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Schiller Burger",
        address: "Herrfurthstr. 7 (Weisestr.), 12049 Berlin, Deutschland",
        fee: "",
        byline: "In case you need some good portion of energy, visit",
        url: "schillerburger.com/"
      },
      %{
        name: "Doyum Grillhaus",
        address: "Admiralstr. 38 Berlin",
        fee: "",
        byline: "While preparing for the party we strongly recommend to dine",
        url: "doyum-restaurant.de/"
      },
      %{
        name: "Klunkerkranich",
        address: "Karl-Marx-Str. 66, 12043 Berlin, Deutschland",
        fee: "",
        byline: "And the go party",
        url: "http://klunkerkranich.org/"
      },
      %{
        name: "Sisyphos",
        address: "Hauptsr. 15, 10317 Berlin",
        fee: "",
        byline: "And maybe later",
        url: "http://sisyphos-berlin.net"
      }
    ]
  end

  def get_itinerary(@guided_tours, @local_bars) do
    [
      %{
        name: "Berlin Essentials: sightseeing and cuisine",
        address: "",
        fee: "",
        byline: "If you want to experience Berlin like a local, visit",
        url:
          "https://www.likealocalguide.com/berlin/tours/berlin-sightseeing-essentials-local-cuisine?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Famous insider walk in Berlin",
        address: "",
        fee: "",
        byline: "Or maybe famous insider walk",
        url:
          "https://www.likealocalguide.com/berlin/tours/the-famous-insider-walk-in-berlin?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Bâteau Ivre",
        address: "Oranienstr. 18, Berlin",
        fee: "",
        byline: "In case you don’t know where to have breakfast, try",
        url: "https://www.facebook.com/BateauIvreKreuzberg/"
      },
      %{
        name: "Curry36",
        address: "Mehringdamm 36, 10961 Berlin",
        fee: "",
        byline: "After walking we surely think you will like to visit",
        url: "http://www.curry36.de/"
      },
      %{
        name: "Craft Beer and Breweries Tour",
        address: "",
        fee: "",
        byline: "In case you are interested in crafted beer, join the tour",
        url:
          "https://www.likealocalguide.com/berlin/tours/craft-beer-breweries-tour-of-berlin?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=alternative-tours"
      },
      %{
        name: "Parker Bowles",
        address: "Prinzenstr. 85d Moritzplatz 10969 Berlin",
        fee: "",
        byline: "Later if you still decide to eat somewhere check",
        url: "http://parker-bowles.com/en/kontakt/"
      },
      %{
        name: "Prinzipal",
        address: "178 Oranienstraße, Berlin, 10999, Germany",
        fee: "",
        byline: "Or you could visit later",
        url: "http://www.prinzipal-kreuzberg.com/website/"
      },
      %{
        name: "Lebowski",
        address: "Niederbarnimstr. 23, Berlin",
        fee: "",
        byline: "Or you need good grounds for partying, visit",
        url: "https://www.facebook.com/pages/Lebowski/157730124251200"
      }
    ]
  end

  def get_itinerary(@guided_tours, @cuisine) do
    [
      %{
        name:
          "Berlin Wall Bike Tour (rent a bike and ride all the way starting from East Side Gallery)",
        address: "",
        fee: "",
        byline: "The best way to extend your understanding the city is to cycle through",
        url: "https://www.visitberlin.de/en/berlin-wall-bike-tour"
      },
      %{
        name: "Tadshikische Teestube",
        address: "Oranienburger Str. 27 Berlin",
        fee: "",
        byline: "Have a morning boost",
        url: "http://www.facebook.com/pages/Tadshikische-Teestube/423281914430765"
      },
      %{
        name: "ORA",
        address: "Oranienplatz 14, 10999 Berlin",
        fee: "",
        byline: "While during the day we highly recommend to visit",
        url: "https://www.facebook.com/oraberlin/"
      },
      %{
        name: "Food, Art, History & Culture",
        address: "",
        fee: "",
        byline: "We would also suggest to do a special tour",
        url:
          "https://www.likealocalguide.com/berlin/tours/this-is-berlin-food-art-history-culture?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Speisehaus",
        address: "Wühlischstr. 30 Berlin",
        fee: "",
        byline: "And if you are still hungry in the evening check",
        url: "https://www.speisehaus-berlin.de"
      },
      %{
        name: "Kimchi Princess",
        address: "Skalitzer Str. 36 Berlin",
        fee: "",
        byline: "Or this crazy Korean BBQ",
        url: "http://www.kimchiprincess.com"
      }
    ]
  end

  def get_itinerary(@guided_tours, @nite_life) do
    [
      %{
        name: "Berlin Essentials: sightseeing and cuisine",
        address: "",
        fee: "",
        byline: "Exploring Berlin while walking around the city is the coolest thing you can do",
        url:
          "https://www.likealocalguide.com/berlin/tours/berlin-sightseeing-essentials-local-cuisine?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Best of Potsdam, Day tour from Berlin",
        address: "",
        fee: "",
        byline: "Or if you need a bit fresh air for thought visit",
        url:
          "https://www.likealocalguide.com/berlin/tours/best-of-potsdam-day-tour-from-berlin?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "The Future Breakfast",
        address: "Briesestr. 9, Neukölln Berlin",
        fee: "",
        byline: "We love breakfasts",
        url: "http://thefuturebreakfast.com"
      },
      %{
        name: "Cielo Di Berlino",
        address: "Monumentenstr. 31 Berlin",
        fee: "",
        byline: "However not less dear to us is the lunch",
        url: "http://cielo-di-berlino.de"
      },
      %{
        name: "Weinblatt",
        address: "Dieffenbachstr. 59 Berlin",
        fee: "",
        byline: "However if you up for a meaty lunch",
        url: "http://knofi.de/dieffenbachstr.htm"
      },
      %{
        name: "Craft Beer and Breweries Tour",
        address: "",
        fee: "",
        byline: " In case you want to start celebrating the evening earlier, visit",
        url:
          "https://www.likealocalguide.com/berlin/tours/craft-beer-breweries-tour-of-berlin?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=alternative-tours"
      },
      %{
        name: "Il Ritrovo",
        address: "Gabriel-Max-Straße 2 Berlin",
        fee: "",
        byline: "And the night might open with Italian Punk pizza",
        url: "https://www.facebook.com/pages/Il-Ritrovo/135125123201418"
      },
      %{
        name: "YAAM BERLIN",
        address: "3 An der Schillingbrücke, Berlin, 10243, Germany",
        fee: "",
        byline: "Berlin bars will call for you later and that’s why you definitely should visit",
        url: "http://www.yaam.de/"
      },
      %{
        name: "Zosch",
        address: "Tucholskystr. 30 Berlin",
        fee: "",
        byline: "Or",
        url: "http://www.zosch-berlin.de/index.php"
      },
      %{
        name: "AboutParty",
        address: "Markgrafendamm 24c 10245 Berlin Friedrichshain",
        fee: "",
        byline: "Later that night maybe visit",
        url: "http://aboutparty.net "
      },
      %{
        name: "Clärchens Ballhaus",
        address: "Auguststraße 24 Berlin",
        fee: "",
        byline: "Or if you prefer a bit more shiny stuff, visit",
        url: "http://www.ballhaus.de/en/"
      },
      %{
        name: "Das Hotel",
        address: "Mariannenstr. 26 Berlin",
        fee: "",
        byline: "And vinyl forever",
        url: "http://dashotelclassic.blogspot.de"
      }
    ]
  end

  def get_itinerary(@theme_tours, @local_bars) do
    [
      %{
        name: "Berlin Wall Memorial",
        address: "Bernauer Straße 111, Prenzlauer Berg",
        fee: "",
        byline: "Check",
        url: "http://www.berliner-mauer-gedenkstaette.de/en/"
      },
      %{
        name: "Fuchsbau",
        address: "Planufer 93-95 Berlin",
        fee: "",
        byline: "Maybe before you would like to have a breakfast",
        url: "https://www.facebook.com/derfuchsbau/"
      },
      %{
        name: "Schwarzes Café",
        address: "Kantstrasse 148, 10623 Berlin",
        fee: "",
        byline: "Or",
        url: "https://www.schwarzescafe-berlin.de/"
      },
      %{
        name: "Food, Art, History & Culture",
        address: "",
        fee: "",
        byline: "To combine pleasant with tasty, visit",
        url:
          "https://www.likealocalguide.com/berlin/tours/this-is-berlin-food-art-history-culture?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Bike tour along the Spree",
        address: "",
        fee: "",
        byline: "A good additional could be a bike tour",
        url: "https://www.visitberlin.de/en/tour-51-cycling-along-river-spree"
      },
      %{
        name: "Shiso Burger",
        address: "Auguststr. 29c, 10119 Berlin, Deutschland",
        fee: "",
        byline: "Lunch",
        url: "http://www.shisoburger.de"
      },
      %{
        name: "Ushido",
        address: "Lychener Straße 18 Berlin",
        fee: "",
        byline: "And dinner",
        url: "http://www.ushido-bbq.com"
      },
      %{
        name: "Perlin",
        address: "Griebenowstr. 5 Berlin",
        fee: "",
        byline: "But the best of Berlin comes at night. Check",
        url: "http://weinerei.com/perlin"
      },
      %{
        name: "Promenaden-Eck",
        address: "Schillerpromenade 11 12049 Berlin Germany",
        fee: "",
        byline: "Or",
        url: "http://www.promenaden-eck.de"
      },
      %{
        name: "Mano",
        address: "Skalitzer Str. 46A Berlin",
        fee: "",
        byline: "Or",
        url: "https://www.facebook.com/mano.cafe"
      }
    ]
  end

  def get_itinerary(@theme_tours, @cuisine) do
    [
      %{
        name:
          "Berlin Wall Bike Tour (rent a bike and ride all the way starting from East Side Gallery)",
        address: "",
        fee: "",
        byline: "Good theme based tours always start",
        url: "https://www.visitberlin.de/en/berlin-wall-bike-tour"
      },
      %{
        name: "Oslo Kaffebar",
        address: "Eichendorffstr. 13 Berlin",
        fee: "",
        byline: "Perhaps first you would like to have breakfast",
        url: "http://www.oslokaffebar.com"
      },
      %{
        name: "Michelberger Hotel",
        address: "Warschauer Straße 39 Berlin",
        fee: "",
        byline: "Or",
        url: "http://michelbergerhotel.com/de/"
      },
      %{
        name: "Famous insider walk in Berlin",
        address: "",
        fee: "",
        byline: "We guess you would love to visit",
        url:
          "https://www.likealocalguide.com/berlin/tours/the-famous-insider-walk-in-berlin?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "ORA",
        address: "Oranienplatz 14, 10999 Berlin",
        fee: "",
        byline: "Maybe after that you could have a nice lunch",
        url: "https://www.facebook.com/oraberlin/"
      },
      %{
        name: "1990 Vegan Living",
        address: "Krossener Str. 19 (Boxhagener Platz), 10245 Berlin, Deutschland",
        fee: "",
        byline: "And then dinner",
        url: "https://www.restaurant1990.de"
      },
      %{
        name: "Hashi Japanese Kitchen",
        address: "Rosenthaler Str. 63 Berlin",
        fee: "",
        byline: "Or",
        url: "http://hashi-kitchen.de/en/"
      },
      %{
        name: "Prinzipal",
        address: "178 Oranienstraße, Berlin, 10999, Germany",
        fee: "",
        byline: "Pick your favorite bar, visit",
        url: "http://www.prinzipal-kreuzberg.com/website/"
      },
      %{
        name: "YAAM BERLIN",
        address: "3 An der Schillingbrücke, Berlin, 10243, Germany",
        fee: "",
        byline: "Or",
        url: "http://www.yaam.de/"
      },
      %{
        name: "Lebowski",
        address: "Niederbarnimstr. 23 Berlin",
        fee: "",
        byline: "",
        url: "https://www.facebook.com/pages/Lebowski/157730124251200"
      },
      %{
        name: "Zosch",
        address: "Tucholskystr. 30 Berlin",
        fee: "",
        byline: "",
        url: "http://www.zosch-berlin.de"
      }
    ]
  end

  def get_itinerary(@theme_tours, @nite_life) do
    [
      %{
        name: "Berlin Essentials: sightseeing and cuisine",
        address: "",
        fee: "",
        byline: "How about to get to know Berlin by visiting",
        url:
          "https://www.likealocalguide.com/berlin/tours/berlin-sightseeing-essentials-local-cuisine?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Einstein",
        address: "Kurfürstenstraße 58 10785 Berlin",
        fee: "",
        byline: "We believe that breakfasts that recharge for the whole day can be found",
        url: "https://www.cafeeinstein.com/menu/"
      },
      %{
        name: "Berlin behind the Wall (Cold war)",
        address: "",
        fee: "",
        byline: "How about a bit of a history",
        url:
          "https://www.likealocalguide.com/berlin/tours/cold-war-berlin-behind-the-wall?utm_campaign=marketplace_click&utm_medium=tours_page_normal&utm_source=berlin&utm_content=walking-tours"
      },
      %{
        name: "Curry36",
        address: "Mehringdamm 36, 10961 Berlin",
        fee: "",
        byline: "Well if you will get hungry than check",
        url: "http://www.curry36.de"
      },
      %{
        name: "ORA",
        address: "Oranienplatz 14, 10999 Berlin",
        fee: "",
        byline: "And",
        url: "https://www.facebook.com/oraberlin/"
      },
      %{
        name: "Burgermeister",
        address: "Oberbaumstraße 8 Berlin",
        fee: "",
        byline: "Don’t forget to grab a good Burger",
        url: "http://burger-meister.de"
      },
      %{
        name: "AN URBAN GARDEN",
        address: "35-38 Prinzenstraße, Berlin",
        fee: "",
        byline: "Or perhaps you would like to visit",
        url: "https://www.berlin.de/kultur-und-tickets/tipps/2407321-1678259-urban-gardening.html"
      },
      %{
        name: "Katteschmaus (cafe bar club)",
        address: "KaterHolzig, Michaelkirchstr. 23, 10179 Berlin",
        fee: "",
        byline: "When the time for party comes check maybe first",
        url: "http://www.katerholzig.de/restaurant"
      },
      %{
        name: "Sisyphos",
        address: "Hauptsr. 15, 10317 Berlin",
        fee: "",
        byline: "And who knows how the evening will go, those could be handy to know",
        url: "http://sisyphos-berlin.net"
      },
      %{
        name: "Alte Kantine in der Kulturbrauerei",
        address: "Knaackstr. 97 Berlin",
        fee: "",
        byline: "",
        url: "https://www.facebook.com/pages/Kulturbrauerei-Alte-Kantine/407678825910435"
      }
    ]
  end

  def get_itinerary("@exploring", "@local_bars") do
    [
      %{
        name: "DDR Museum",
        address: "Karl-Liebknecht-Str. 1, Mitte 10178",
        fee: "€9.50",
        byline: "Have you visited",
        url: "https://www.ddr-museum.de/en"
      },
      %{
        name: "Michelberger Hotel",
        address: "Warschauer Straße 39 Berlin",
        fee: "",
        byline: "Well maybe before you would consider to grab a good breakfast",
        url: "http://michelbergerhotel.com/de/"
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      },
      %{
        name: "",
        address: "",
        fee: "",
        byline: "",
        url: ""
      }
    ]
  end

  def get_itinerary(_a, _b) do
    get_itinerary(@guided_tours, @nite_life)
  end

  def get_itinerary(its) do
    its
    |> Enum.map(fn %{name: name} = it ->
      case Map.has_key?(it, :byline) do
        true ->
          %{it | byline: "#{it.byline} at #{name}"}

        false ->
          Map.put(it, :byline, "View Details")
      end
    end)

    # |> Enum.shuffle()
  end
end
