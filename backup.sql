--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.5.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: boards; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE boards (
    board_id integer NOT NULL,
    board_name character varying(64)
);


ALTER TABLE boards OWNER TO vagrant;

--
-- Name: boards_board_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE boards_board_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE boards_board_id_seq OWNER TO vagrant;

--
-- Name: boards_board_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE boards_board_id_seq OWNED BY boards.board_id;


--
-- Name: boardusers; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE boardusers (
    bu_id integer NOT NULL,
    user_id integer NOT NULL,
    board_id integer NOT NULL
);


ALTER TABLE boardusers OWNER TO vagrant;

--
-- Name: boardusers_bu_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE boardusers_bu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE boardusers_bu_id_seq OWNER TO vagrant;

--
-- Name: boardusers_bu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE boardusers_bu_id_seq OWNED BY boardusers.bu_id;


--
-- Name: bookgenres; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE bookgenres (
    bg_id integer NOT NULL,
    book_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE bookgenres OWNER TO vagrant;

--
-- Name: bookgenres_bg_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE bookgenres_bg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bookgenres_bg_id_seq OWNER TO vagrant;

--
-- Name: bookgenres_bg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE bookgenres_bg_id_seq OWNED BY bookgenres.bg_id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE books (
    book_id integer NOT NULL,
    title character varying(64),
    author character varying(64),
    goodreads_id character varying(64),
    image_url character varying(300),
    description character varying(2000)
);


ALTER TABLE books OWNER TO vagrant;

--
-- Name: books_book_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE books_book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE books_book_id_seq OWNER TO vagrant;

--
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE books_book_id_seq OWNED BY books.book_id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE genres (
    genre_id integer NOT NULL,
    name character varying(64)
);


ALTER TABLE genres OWNER TO vagrant;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE genres_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE genres_genre_id_seq OWNER TO vagrant;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE genres_genre_id_seq OWNED BY genres.genre_id;


--
-- Name: squares; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE squares (
    square_id integer NOT NULL,
    board_id integer NOT NULL,
    genre_id integer NOT NULL,
    x_coord integer,
    y_coord integer
);


ALTER TABLE squares OWNER TO vagrant;

--
-- Name: squares_square_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE squares_square_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE squares_square_id_seq OWNER TO vagrant;

--
-- Name: squares_square_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE squares_square_id_seq OWNED BY squares.square_id;


--
-- Name: squareusers; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE squareusers (
    squ_id integer NOT NULL,
    square_id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL
);


ALTER TABLE squareusers OWNER TO vagrant;

--
-- Name: squareusers_squ_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE squareusers_squ_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE squareusers_squ_id_seq OWNER TO vagrant;

--
-- Name: squareusers_squ_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE squareusers_squ_id_seq OWNED BY squareusers.squ_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE users (
    user_id integer NOT NULL,
    email character varying(64),
    password character varying(64),
    first_name character varying(30),
    last_name character varying(30)
);


ALTER TABLE users OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: board_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY boards ALTER COLUMN board_id SET DEFAULT nextval('boards_board_id_seq'::regclass);


--
-- Name: bu_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY boardusers ALTER COLUMN bu_id SET DEFAULT nextval('boardusers_bu_id_seq'::regclass);


--
-- Name: bg_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY bookgenres ALTER COLUMN bg_id SET DEFAULT nextval('bookgenres_bg_id_seq'::regclass);


--
-- Name: book_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY books ALTER COLUMN book_id SET DEFAULT nextval('books_book_id_seq'::regclass);


--
-- Name: genre_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY genres ALTER COLUMN genre_id SET DEFAULT nextval('genres_genre_id_seq'::regclass);


--
-- Name: square_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squares ALTER COLUMN square_id SET DEFAULT nextval('squares_square_id_seq'::regclass);


--
-- Name: squ_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squareusers ALTER COLUMN squ_id SET DEFAULT nextval('squareusers_squ_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: boards; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY boards (board_id, board_name) FROM stdin;
1	My Board
2	Bar Chart Test
3	New Board
4	Test
5	Test #2
6	Test #3
7	Button Test
8	Test Alec
9	Book Bingo March 2017
10	New Board
11	New Board
12	New Board
13	Grace's Board
14	Chart Test
15	Book Club
16	Jane's Board
17	Demo Night
\.


--
-- Name: boards_board_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('boards_board_id_seq', 17, true);


--
-- Data for Name: boardusers; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY boardusers (bu_id, user_id, board_id) FROM stdin;
1	1	1
2	2	1
3	1	2
4	3	2
5	3	3
6	1	4
7	1	5
8	1	6
9	1	7
10	4	8
11	5	9
12	1	9
13	2	9
14	5	10
15	5	11
16	5	12
17	5	13
18	5	14
19	7	15
20	1	15
21	2	15
22	7	16
23	7	17
\.


--
-- Name: boardusers_bu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('boardusers_bu_id_seq', 23, true);


--
-- Data for Name: bookgenres; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY bookgenres (bg_id, book_id, genre_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	23
5	5	188
6	6	193
7	7	178
8	8	184
9	9	178
10	10	182
11	11	181
12	12	180
13	13	179
14	14	196
15	15	179
16	16	191
17	17	192
18	18	328
19	19	334
20	20	346
21	21	329
22	22	332
23	23	329
24	24	383
25	25	377
\.


--
-- Name: bookgenres_bg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('bookgenres_bg_id_seq', 25, true);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY books (book_id, title, author, goodreads_id, image_url, description) FROM stdin;
1	Sample Fantasy Book	Terry Pratchett	\N	\N	\N
2	Sample Romance Book	Jane Austen	\N	\N	\N
3	Pride and Prejudice	Jane Austen	1885	https://images.gr-assets.com/books/1320399351m/1885.jpg	“It is a truth universally acknowledged, that a single man in possession of a good fortune must be in want of a wife.” So begins Pride and Prejudice, Jane Austen’s witty comedy of manners—one of the most popular novels of all time—that features splendidly civilized sparring between the proud Mr. Darcy and the prejudiced Elizabeth Bennet as they play out their spirited courtship in a series of eighteenth-century drawing-room intrigues. Renowned literary critic and historian George Saintsbury in 1894 declared it the “most perfect, the most characteristic, the most eminently quintessential of its author’s works,” and Eudora Welty in the twentieth century described it as “irresistible and as nearly flawless as any fiction could be.”--penguinrandomhouse.com
4	The Hunger Games	Suzanne Collins	2767052	https://images.gr-assets.com/books/1447303603m/2767052.jpg	Winning will make you famous. Losing means certain death.The nation of Panem, formed from a post-apocalyptic North America, is a country that consists of a wealthy Capitol region surrounded by 12 poorer districts. Early in its history, a rebellion led by a 13th district against the Capitol resulted in its destruction and the creation of an annual televised event known as the Hunger Games. In punishment, and as a reminder of the power and grace of the Capitol, each district must yield one boy and one girl between the ages of 12 and 18 through a lottery system to participate in the games. The 'tributes' are chosen during the annual Reaping and are forced to fight to the death, leaving only one survivor to claim victory.When 16-year-old Katniss's young sister, Prim, is selected as District 12's female representative, Katniss volunteers to take her place. She and her male counterpart Peeta, are pitted against bigger, stronger representatives, some of whom have trained for this their whole lives. , she sees it as a death sentence. But Katniss has been close to death before. For her, survival is second nature.
5	The House of the Spirits	Isabel Allende	9328	https://images.gr-assets.com/books/1358615501m/9328.jpg	In one of the most important and beloved Latin American works of the twentieth century, Isabel Allende weaves a luminous tapestry of three generations of the Trueba family, revealing both triumphs and tragedies. Here is patriarch Esteban, whose wild desires and political machinations are tempered only by his love for his ethereal wife, Clara, a woman touched by an otherworldly hand. Their daughter, Blanca, whose forbidden love for a man Esteban has deemed unworthy infuriates her father, yet will produce his greatest joy: his granddaughter Alba, a beautiful, ambitious girl who will lead the family and their country into a revolutionary future.The House of the Spirits is an enthralling saga that spans decades and lives, twining the personal and the political into an epic novel of love, magic, and fate.
6	The Pelican Brief	John Grisham	32499	https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png	In suburban Georgetown a killer's Reeboks whisper on the front floor of a posh home... In a seedy D.C. porno house a patron is swiftly garroted to death... The next day America learns that two of its Supreme Court justices have been assassinated. And in New Orleans, a young law student prepares a legal brief... To Darby Shaw it was no more than a legal shot in the dark, a brilliant guess. To the Washington establishment it was political dynamite. Suddenly Darby is witness to a murder -- a murder intended for her. Going underground, she finds there is only one person she can trust -- an ambitious reporter after a newsbreak hotter than Watergate -- to help her piece together the deadly puzzle. Somewhere between the bayous of  Louisiana and the White House's inner sanctums, a violent cover-up is being engineered. For someone has read Darby's brief. Someone who will stop at nothing to destroy the evidence of an unthinkable crime.
7	The Handmaid's Tale	Margaret Atwood	38447	https://images.gr-assets.com/books/1473094781m/38447.jpg	Offred is a Handmaid in the Republic of Gilead. She may leave the home of the Commander and his wife once a day to walk to food markets whose signs are now pictures instead of words because women are no longer allowed to read. She must lie on her back once a month and pray that the Commander makes her pregnant, because in an age of declining births, Offred and the other Handmaids are valued only if their ovaries are viable. Offred can remember the years before, when she lived and made love with her husband, Luke; when she played with and protected her daughter; when she had a job, money of her own, and access to knowledge. But all of that is gone now...
8	Harry Potter and the Half-Blood Prince	J. K. Rowling	1	https://images.gr-assets.com/books/1361039191m/1.jpg	It is the middle of the summer, but there is an unseasonal mist pressing against the windowpanes. Harry Potter is waiting nervously in his bedroom at the Dursleys' house in Privet Drive for a visit from Professor Dumbledore himself. One of the last times he saw the Headmaster was in a fierce one-to-one duel with Lord Voldemort, and Harry can't quite believe that Professor Dumbledore will actually appear at the Dursleys' of all places. Why is the Professor coming to visit him now? What is it that cannot wait until Harry returns to Hogwarts in a few weeks' time? Harry's sixth year at Hogwarts has already got off to an unusual start, as the worlds of Muggle and magic start to intertwine...J.K. Rowling charts Harry Potter's latest adventures in his sixth year at Hogwarts with consummate skill and in breathtaking fashion.
9	Dracula	Bram Stoker	17245	https://images.gr-assets.com/books/1387151694m/17245.jpg	You can find an alternative cover edition for this ISBN here.A rich selection of background and source materials is provided in three areas: Contexts includes probable inspirations for Dracula in the earlier works of James Malcolm Rymer and Emily Gerard. Also included are a discussion of Stoker's working notes for the novel and "Dracula's Guest," the original opening chapter to Dracula. Reviews and Reactions reprints five early reviews of the novel. "Dramatic and Film Variations" focuses on theater and film adaptations of Dracula, two indications of the novel's unwavering appeal. David J. Skal, Gregory A. Waller, and Nina Auerbach offer their varied perspectives. Checklists of both dramatic and film adaptations are included.Criticism collects seven theoretical interpretations of Dracula by Phyllis A. Roth, Carol A. Senf, Franco Moretti, Christopher Craft, Bram Dijsktra, Stephen D. Arata, and Talia Schaffer.A Chronology and a Selected Bibliography are included.
10	Nine Stories	J.D. Salinger	4009	https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png	The Stories: "A Perfect Day for Bananafish" (1948) "Uncle Wiggily in Connecticut" (1948) "Just Before the War with the Eskimos" (1948) "The Laughing Man" (1949) "Down at the Dinghy" (1949) "For Esmé – with Love and Squalor" (1950) "Pretty Mouth and Green My Eyes" (1951) "De Daumier-Smith's Blue Period" (1952) "Teddy" (1953)
11	War and Peace	Leo Tolstoy	656	https://images.gr-assets.com/books/1413215930m/656.jpg	Tolstoy's epic masterpiece intertwines the lives of private and public individuals during the time of the Napoleonic wars and the French invasion of Russia. The fortunes of the Rostovs and the Bolkonskys, of Pierre, Natasha, and Andrei, are intimately connected with the national history that is played out in parallel with their lives. Balls and soirees alternate with councils of war and the machinations of statesmen and generals, scenes of violent battles with everyday human passions in a work whose extraordinary imaginative power has never been surpassed. The prodigious cast of characters, seem to act and move as if connected by threads of destiny as the novel relentlessly questions ideas of free will, fate, and providence. Yet Tolstoy's portrayal of marital relations and scenes of domesticity is as truthful and poignant as the grand themes that underlie them.
12	Eat, Pray, Love	Elizabeth Gilbert	19501	https://images.gr-assets.com/books/1294023455m/19501.jpg	Elizabeth Gilbert’s Eat Pray Love touched the world and changed countless lives, inspiring and empowering millions of readers to search for their own best selves. Now, this beloved and iconic book returns in a beautiful 10th anniversary edition, complete with an updated introduction from the author, to launch a whole new generation of fans. In her early thirties, Elizabeth Gilbert had everything a modern American woman was supposed to want—husband, country home, successful career—but instead of feeling happy and fulfilled, she was consumed by panic and confusion. This wise and rapturous book is the story of how she left behind all these outward marks of success, and set out to explore three different aspects of her nature, against the backdrop of three different cultures: pleasure in Italy, devotion in India, and on the Indonesian island of Bali, a balance between worldly enjoyment and divine transcendence.
13	Lord of the Rings	J.R.R. Tolkien	33	https://images.gr-assets.com/books/1411114164m/33.jpg	A fantastic starter set for new Tolkien fans or readers interested in rediscovering the magic of Middle-earth, this three-volume box set features paperback editions of the complete trilogy -- The Fellowship of the Ring, The Two Towers, and The Return of the King -- each with art from the New Line Productions feature film on the cover.J.R.R. Tolkien's The Lord of the Rings trilogy is a genuine masterpiece. The most widely read and influential fantasy epic of all time, it is also quite simply one of the most memorable and beloved tales ever told. Originally published in 1954, The Lord of the Rings set the framework upon which all epic/quest fantasy since has been built. Through the urgings of the enigmatic wizard Gandalf, young hobbit Frodo Baggins embarks on an urgent, incredibly treacherous journey to destroy the One Ring. This ring -- created and then lost by the Dark Lord, Sauron, centuries earlier -- is a weapon of evil, one that Sauron desperately wants returned to him. With the power of the ring once again his own, the Dark Lord will unleash his wrath upon all of Middle-earth. The only way to prevent this horrible fate from becoming reality is to return the Ring to Mordor, the only place it can be destroyed. Unfortunately for our heroes, Mordor is also Sauron's lair. The Lord of the Rings trilogy is essential reading not only for fans of fantasy but for lovers of classic literature as well...Librarian's note: this edition shares an ISBN with the 2004 edition published by Houghton Mifflin Company
14	Fates and Furies	Lauren Groff	24612118	https://images.gr-assets.com/books/1434750235m/24612118.jpg	Every story has two sides. Every relationship has two perspectives. And sometimes, it turns out, the key to a great marriage is not its truths but its secrets. At the core of this rich, expansive, layered novel, Lauren Groff presents the story of one such marriage over the course of twenty-four years.At age twenty-two, Lotto and Mathilde are tall, glamorous, madly in love, and destined for greatness. A decade later, their marriage is still the envy of their friends, but with an electric thrill we understand that things are even more complicated and remarkable than they have seemed.
15	American Gods	Neil Gaiman	30165203	https://images.gr-assets.com/books/1462924585m/30165203.jpg	A storm is coming...Locked behind bars for three years, Shadow did his time, quietly waiting for the magic day when he could return to Eagle Point, Indiana. A man no longer scared of what tomorrow might bring, all he wanted was to be with Laura, the wife he deeply loved, and start a new life.But just days before his release, Laura and Shadow’s best friend are killed in an accident. With his life in pieces and nothing to keep him tethered, Shadow accepts a job from a beguiling stranger he meets on the way home, an enigmatic man who calls himself Mr. Wednesday. A trickster and rogue, Wednesday seems to know more about Shadow than Shadow does himself.Life as Wednesday’s bodyguard, driver, and errand boy is far more interesting and dangerous than Shadow ever imagined—it is a job that takes him on a dark and strange road trip and introduces him to a host of eccentric characters whose fates are mysteriously intertwined with his own. Along the way Shadow will learn that the past never dies; that everyone, including his beloved Laura, harbors secrets; and that dreams, totems, legends, and myths are more real than we know. Ultimately, he will discover that beneath the placid surface of everyday life a storm is brewing—an epic war for the very soul of America—and that he is standing squarely in its path.
16	The Other Boleyn Girl	Philippa Gregory	37470	https://images.gr-assets.com/books/1355932638m/37470.jpg	Two sisters competing for the greatest prize: The love of a kingWhen Mary Boleyn comes to court as an innocent girl of fourteen, she catches the eye of Henry VIII. Dazzled, Mary falls in love with both her golden prince and her growing role as unofficial queen. However, she soon realises just how much she is a pawn in her family's ambitious plots as the king's interest begins to wane and she is forced to step aside for her best friend and rival: her sister, Anne. Then Mary knows that she must defy her family and her king and take fate into her own hands.A rich and compelling novel of love, sex, ambition, and intrigue, The Other Boleyn Girl introduces a woman of extraordinary determination and desire who lived at the heart of the most exciting and glamourous court in Europe and survived by following her heart.
17	Watchmen	Alan Moore	472331	https://images.gr-assets.com/books/1442239711m/472331.jpg	This Hugo Award-winning graphic novel chronicles the fall from grace of a group of super-heroes plagued by all-too-human failings. Along the way, the concept of the super-hero is dissected as the heroes are stalked by an unknown assassin.One of the most influential graphic novels of all time and a perennial best-seller, Watchmen has been studied on college campuses across the nation and is considered a gateway title, leading readers to other graphic novels such as V for Vendetta, Batman: The Dark Knight Returns and The Sandman series.
18	Homegoing	Yaa Gyasi	27071490	https://images.gr-assets.com/books/1448108591m/27071490.jpg	The unforgettable New York Times best seller begins with the story of two half-sisters, separated by forces beyond their control: one sold into slavery, the other married to a British slaver. Written with tremendous sweep and power, Homegoing traces the generations of family who follow, as their destinies lead them through two continents and three hundred years of history, each life indeliably drawn, as the legacy of slavery is fully revealed in light of the present day.Effia and Esi are born into different villages in eighteenth-century Ghana. Effia is married off to an Englishman and lives in comfort in the palatial rooms of Cape Coast Castle. Unbeknownst to Effia, her sister, Esi, is imprisoned beneath her in the castle’s dungeons, sold with thousands of others into the Gold Coast’s booming slave trade, and shipped off to America, where her children and grandchildren will be raised in slavery. One thread of Homegoing follows Effia’s descendants through centuries of warfare in Ghana, as the Fante and Asante nations wrestle with the slave trade and British colonization. The other thread follows Esi and her children into America. From the plantations of the South to the Civil War and the Great Migration, from the coal mines of Pratt City, Alabama, to the jazz clubs and dope houses of twentieth-century Harlem, right up through the present day, Homegoing makes history visceral, and captures, with singular and stunning immediacy, how the memory of captivity came to be inscribed in the soul of a nation.~penguinrandomhouse.com
19	Crime and Punishment	Fyodor Dostoyevsky	7144	https://images.gr-assets.com/books/1382846449m/7144.jpg	Through the story of the brilliant but conflicted young Raskolnikov and the murder he commits, Fyodor Dostoevsky explores the theme of redemption through suffering. Crime and Punishment put Dostoevsky at the forefront of Russian writers when it appeared in 1866 and is now one of the most famous and influential novels in world literature.The poverty-stricken Raskolnikov, a talented student, devises a theory about extraordinary men being above the law, since in their brilliance they think “new thoughts” and so contribute to society. He then sets out to prove his theory by murdering a vile, cynical old pawnbroker and her sister. The act brings Raskolnikov into contact with his own buried conscience and with two characters — the deeply religious Sonia, who has endured great suffering, and Porfiry, the intelligent and discerning official who is charged with investigating the murder — both of whom compel Raskolnikov to feel the split in his nature. Dostoevsky provides readers with a suspenseful, penetrating psychological analysis that goes beyond the crime — which in the course of the novel demands drastic punishment — to reveal something about the human condition: The more we intellectualize, the more imprisoned we become.
20	Bossypants	Tina Fey	9418327	https://images.gr-assets.com/books/1481509554m/9418327.jpg	Before Liz Lemon, before "Weekend Update," before "Sarah Palin," Tina Fey was just a young girl with a dream: a recurring stress dream that she was being chased through a local airport by her middle-school gym teacher. She also had a dream that one day she would be a comedian on TV.She has seen both these dreams come true.At last, Tina Fey's story can be told. From her youthful days as a vicious nerd to her tour of duty on Saturday Night Live; from her passionately halfhearted pursuit of physical beauty to her life as a mother eating things off the floor; from her one-sided college romance to her nearly fatal honeymoon—from the beginning of this paragraph to this final sentence.Tina Fey reveals all, and proves what we've all suspected: you're no one until someone calls you bossy.(Includes Special, Never-Before-Solicited Opinions on Breastfeeding, Princesses, Photoshop, the Electoral Process, and Italian Rum Cake!)An unabridged recording on 5 CDs (5.5 Hours).
21	Lord of the Rings	J. R. R. Tolkien	33	https://images.gr-assets.com/books/1411114164m/33.jpg	A fantastic starter set for new Tolkien fans or readers interested in rediscovering the magic of Middle-earth, this three-volume box set features paperback editions of the complete trilogy -- The Fellowship of the Ring, The Two Towers, and The Return of the King -- each with art from the New Line Productions feature film on the cover.J.R.R. Tolkien's The Lord of the Rings trilogy is a genuine masterpiece. The most widely read and influential fantasy epic of all time, it is also quite simply one of the most memorable and beloved tales ever told. Originally published in 1954, The Lord of the Rings set the framework upon which all epic/quest fantasy since has been built. Through the urgings of the enigmatic wizard Gandalf, young hobbit Frodo Baggins embarks on an urgent, incredibly treacherous journey to destroy the One Ring. This ring -- created and then lost by the Dark Lord, Sauron, centuries earlier -- is a weapon of evil, one that Sauron desperately wants returned to him. With the power of the ring once again his own, the Dark Lord will unleash his wrath upon all of Middle-earth. The only way to prevent this horrible fate from becoming reality is to return the Ring to Mordor, the only place it can be destroyed. Unfortunately for our heroes, Mordor is also Sauron's lair. The Lord of the Rings trilogy is essential reading not only for fans of fantasy but for lovers of classic literature as well...Librarian's note: this edition shares an ISBN with the 2004 edition published by Houghton Mifflin Company
22	Nine Stories	J. D. Sallinger	4009	https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png	The Stories: "A Perfect Day for Bananafish" (1948) "Uncle Wiggily in Connecticut" (1948) "Just Before the War with the Eskimos" (1948) "The Laughing Man" (1949) "Down at the Dinghy" (1949) "For Esmé – with Love and Squalor" (1950) "Pretty Mouth and Green My Eyes" (1951) "De Daumier-Smith's Blue Period" (1952) "Teddy" (1953)
23	Neverwhere	Neil Gaiman	14497	https://images.gr-assets.com/books/1348747943m/14497.jpg	Under the streets of London there's a place most people could never even dream of. A city of monsters and saints, murderers and angels, knights in armour and pale girls in black velvet. This is the city of the people who have fallen between the cracks.Richard Mayhew, a young businessman, is going to find out more than enough about this other London. A single act of kindness catapults him out of his workday existence and into a world that is at once eerily familiar and utterly bizarre. And a strange destiny awaits him down here, beneath his native city: Neverwhere.
24	Gone Girl	Gillian Flynn	19288043	https://images.gr-assets.com/books/1397056917m/19288043.jpg	On a warm summer morning in North Carthage, Missouri, it is Nick and Amy Dunne’s fifth wedding anniversary. Presents are being wrapped and reservations are being made when Nick’s clever and beautiful wife disappears. Husband-of-the-Year Nick isn’t doing himself any favors with cringe-worthy daydreams about the slope and shape of his wife’s head, but passages from Amy's diary reveal the alpha-girl perfectionist could have put anyone dangerously on edge. Under mounting pressure from the police and the media—as well as Amy’s fiercely doting parents—the town golden boy parades an endless series of lies, deceits, and inappropriate behavior. Nick is oddly evasive, and he’s definitely bitter—but is he really a killer?
25	The Shining	Stephen King	11588	https://images.gr-assets.com/books/1353277730m/11588.jpg	Danny was only five years old but in the words of old Mr Halloran he was a 'shiner', aglow with psychic voltage. When his father became caretaker of the Overlook Hotel his visions grew frighteningly out of control. As winter closed in and blizzards cut them off, the hotel seemed to develop a life of its own. It was meant to be empty, but who was the lady in Room 217, and who were the masked guests going up and down in the elevator? And why did the hedges shaped like animals seem so alive? Somewhere, somehow there was an evil force in the hotel - and that too had begun to shine...
\.


--
-- Name: books_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('books_book_id_seq', 25, true);


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY genres (genre_id, name) FROM stdin;
1	Fantasy
2	Romance
3	Fiction
4	Fantasy
5	Memoir
6	Literary Classic
7	Short Stories
8	Female Author
9	More Than 500 Pages
10	Non-Fiction
11	Science Fiction
12	Banned Book
13	Magical Realism
14	True Crime
15	FREE SQUARE
16	Historical Fiction
17	Graphic Novel
18	Written The Year You Were Born
19	Dystopia
20	Book Involving Music
21	Recommended By A Friend
22	Biography
23	YA Fiction
24	Romance
25	Color In the Title
26	National Book Award Winner
27	Horror
28	Fiction
29	Fantasy
30	Memoir
31	Literary Classic
32	Short Stories
33	Female Author
34	More Than 500 Pages
35	Non-Fiction
36	Science Fiction
37	Banned Book
38	Magical Realism
39	True Crime
40	FREE SQUARE
41	Historical Fiction
42	Graphic Novel
43	Written The Year You Were Born
44	Dystopia
45	Book Involving Music
46	Recommended By A Friend
47	Biography
48	YA Fiction
49	Romance
50	Color In the Title
51	National Book Award Winner
52	Horror
53	Fiction
54	Fantasy
55	Memoir
56	Literary Classic
57	Short Stories
58	Female Author
59	More Than 500 Pages
60	Non-Fiction
61	Science Fiction
62	Banned Book
63	Magical Realism
64	True Crime
65	FREE SQUARE
66	Historical Fiction
67	Graphic Novel
68	Written The Year You Were Born
69	Dystopia
70	Book Involving Music
71	Recommended By A Friend
72	Biography
73	YA Fiction
74	Romance
75	Color In the Title
76	National Book Award Winner
77	Horror
78	Fiction
79	Fantasy
80	Memoir
81	Literary Classic
82	Short Stories
83	Female Author
84	More Than 500 Pages
85	Non-Fiction
86	Science Fiction
87	Banned Book
88	Magical Realism
89	True Crime
90	FREE SQUARE
91	Historical Fiction
92	Graphic Novel
93	Written The Year You Were Born
94	Dystopia
95	Book Involving Music
96	Recommended By A Friend
97	Biography
98	YA Fiction
99	Romance
100	Color In the Title
101	National Book Award Winner
102	Horror
103	Fiction
104	Fantasy
105	Memoir
106	Literary Classic
107	Short Stories
108	Female Author
109	More Than 500 Pages
110	Non-Fiction
111	Science Fiction
112	Banned Book
113	Magical Realism
114	True Crime
115	FREE SQUARE
116	Historical Fiction
117	Graphic Novel
118	Written The Year You Were Born
119	Dystopia
120	Book Involving Music
121	Recommended By A Friend
122	Biography
123	YA Fiction
124	Romance
125	Color In the Title
126	National Book Award Winner
127	Horror
128	Fiction
129	Fantasy
130	Memoir
131	Literary Classic
132	Short Stories
133	Female Author
134	More Than 500 Pages
135	Non-Fiction
136	Science Fiction
137	Banned Book
138	Magical Realism
139	True Crime
140	FREE SQUARE
141	Historical Fiction
142	Graphic Novel
143	Written The Year You Were Born
144	Dystopia
145	Book Involving Music
146	Recommended By A Friend
147	Biography
148	YA Fiction
149	Romance
150	Color In the Title
151	National Book Award Winner
152	Horror
153	Fiction
154	Fantasty
155	Memoir
156	Literary Classic
157	Short Stories
158	Female Author
159	More Than 500 Pages
160	Non-Fiction
161	Science Fiction
162	Banned Book
163	Magical Realism
164	True Crime
165	FREE SQUARE
166	Historical Fiction
167	Graphic Novel
168	Written The Year You Were Born
169	Dystopia
170	Book Involving Music
171	Recommended By A Friend
172	Biography
173	YA Fiction
174	Romance
175	Color In the Title
176	National Book Award Winner
177	Horror
178	Fiction
179	Fantasy
180	Memoir
181	Literary Classic
182	Short Stories
183	Female Author
184	More Than 500 Pages
185	Non-Fiction
186	Science Fiction
187	Banned Book
188	Magical Realism
189	True Crime
190	FREE SQUARE
191	Historical Fiction
192	Graphic Novel
193	Written The Year You Were Born
194	Dystopia
195	Book Involving Music
196	Recommended By A Friend
197	Biography
198	Young Adult Fiction
199	Romance
200	Color In the Title
201	National Book Award Winner
202	Horror
203	Fiction
204	Fantasy
205	Memoir
206	Literary Classic
207	Short Stories
208	Female Author
209	More Than 500 Pages
210	Non-Fiction
211	Science Fiction
212	Banned Book
213	Magical Realism
214	True Crime
215	FREE SQUARE
216	Historical Fiction
217	Graphic Novel
218	Written The Year You Were Born
219	Dystopia
220	Book Involving Music
221	Recommended By A Friend
222	Biography
223	YA Fiction
224	Romance
225	Color In the Title
226	National Book Award Winner
227	Horror
228	Fiction
229	Fantasy
230	Memoir
231	Literary Classic
232	Short Stories
233	Female Author
234	More Than 500 Pages
235	Non-Fiction
236	Science Fiction
237	Banned Book
238	Magical Realism
239	True Crime
240	FREE SQUARE
241	Historical Fiction
242	Graphic Novel
243	Written The Year You Were Born
244	Dystopia
245	Book Involving Music
246	Recommended By A Friend
247	Biography
248	YA Fiction
249	Romance
250	Color In the Title
251	National Book Award Winner
252	Horror
253	Fiction
254	Fantasy
255	Memoir
256	Literary Classic
257	Short Stories
258	Female Author
259	More Than 500 Pages
260	Non-Fiction
261	Science Fiction
262	Banned Book
263	Magical Realism
264	True Crime
265	FREE SQUARE
266	Historical Fiction
267	Graphic Novel
268	Written The Year You Were Born
269	Dystopia
270	Book Involving Music
271	Recommended By A Friend
272	Biography
273	YA Fiction
274	Romance
275	Color In the Title
276	National Book Award Winner
277	Horror
278	Fiction
279	Fantasy
280	Memoir
281	Literary Classic
282	Short Stories
283	Female Author
284	More Than 500 Pages
285	Non-Fiction
286	Science Fiction
287	Banned Book
288	Magical Realism
289	True Crime
290	FREE SQUARE
291	Historical Fiction
292	Graphic Novel
293	Written The Year You Were Born
294	Dystopia
295	Book Involving Music
296	Recommended By A Friend
297	Biography
298	YA Fiction
299	Romance
300	Color In the Title
301	National Book Award Winner
302	Horror
303	Fiction
304	Fantasy
305	Memoir
306	Literary Classic
307	Short Stories
308	Female Author
309	More Than 500 Pages
310	Non-Fiction
311	Science Fiction
312	Banned Book
313	Magical Realism
314	True Crime
315	FREE SQUARE
316	Historical Fiction
317	Graphic Novel
318	Poetry
319	Dystopia
320	Book Involving Music
321	Humor
322	Biography
323	YA Fiction
324	Romance
325	Color In the Title
326	Feminist Theory
327	Horror
328	Fiction
329	Fantasy
330	Memoir
331	Literary Classic
332	Short Stories
333	Female Author
334	More Than 500 Pages
335	Non-Fiction
336	Science Fiction
337	Banned Book
338	Magical Realism
339	True Crime
340	FREE SQUARE
341	Historical Fiction
342	Graphic Novel
343	Poetry
344	Dystopia
345	Book Involving Music
346	Humor
347	Biography
348	YA Fiction
349	Romance
350	Color In the Title
351	Feminist Theory
352	Horror
353	Fiction
354	Fantasy
355	Memoir
356	Literary Classic
357	Short Stories
358	Female Author
359	More Than 500 Pages
360	Non-Fiction
361	Science Fiction
362	Paranormal
363	Magical Realism
364	True Crime
365	FREE SQUARE
366	Historical Fiction
367	Graphic Novel
368	Poetry
369	Dystopia
370	Book Involving Music
371	Humor
372	Biography
373	YA Fiction
374	Romance
375	Color In the Title
376	Feminist Theory
377	Horror
378	Fiction
379	Fantasy
380	Memoir
381	Literary Classic
382	Short Stories
383	Female Author
384	More Than 500 Pages
385	Non-Fiction
386	Science Fiction
387	Banned Book
388	Magical Realism
389	True Crime
390	FREE SQUARE
391	Historical Fiction
392	Graphic Novel
393	Poetry
394	Dystopia
395	Book Involving Music
396	Humor
397	Biography
398	YA Fiction
399	Romance
400	Color In the Title
401	Feminist Theory
402	Horror
\.


--
-- Name: genres_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('genres_genre_id_seq', 402, true);


--
-- Data for Name: squares; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY squares (square_id, board_id, genre_id, x_coord, y_coord) FROM stdin;
1	1	1	1	2
2	1	2	1	1
3	2	3	1	1
4	2	4	1	2
5	2	5	1	3
6	2	6	1	4
7	2	7	1	5
8	2	8	2	1
9	2	9	2	2
10	2	10	2	3
11	2	11	2	4
12	2	12	2	5
13	2	13	3	1
14	2	14	3	2
15	2	15	3	3
16	2	16	3	4
17	2	17	3	5
18	2	18	4	1
19	2	19	4	2
20	2	20	4	3
21	2	21	4	4
22	2	22	4	5
23	2	23	5	1
24	2	24	5	2
25	2	25	5	3
26	2	26	5	4
27	2	27	5	5
28	3	28	1	1
29	3	29	1	2
30	3	30	1	3
31	3	31	1	4
32	3	32	1	5
33	3	33	2	1
34	3	34	2	2
35	3	35	2	3
36	3	36	2	4
37	3	37	2	5
38	3	38	3	1
39	3	39	3	2
40	3	40	3	3
41	3	41	3	4
42	3	42	3	5
43	3	43	4	1
44	3	44	4	2
45	3	45	4	3
46	3	46	4	4
47	3	47	4	5
48	3	48	5	1
49	3	49	5	2
50	3	50	5	3
51	3	51	5	4
52	3	52	5	5
53	4	53	1	1
54	4	54	1	2
55	4	55	1	3
56	4	56	1	4
57	4	57	1	5
58	4	58	2	1
59	4	59	2	2
60	4	60	2	3
61	4	61	2	4
62	4	62	2	5
63	4	63	3	1
64	4	64	3	2
65	4	65	3	3
66	4	66	3	4
67	4	67	3	5
68	4	68	4	1
69	4	69	4	2
70	4	70	4	3
71	4	71	4	4
72	4	72	4	5
73	4	73	5	1
74	4	74	5	2
75	4	75	5	3
76	4	76	5	4
77	4	77	5	5
78	5	78	1	1
79	5	79	1	2
80	5	80	1	3
81	5	81	1	4
82	5	82	1	5
83	5	83	2	1
84	5	84	2	2
85	5	85	2	3
86	5	86	2	4
87	5	87	2	5
88	5	88	3	1
89	5	89	3	2
90	5	90	3	3
91	5	91	3	4
92	5	92	3	5
93	5	93	4	1
94	5	94	4	2
95	5	95	4	3
96	5	96	4	4
97	5	97	4	5
98	5	98	5	1
99	5	99	5	2
100	5	100	5	3
101	5	101	5	4
102	5	102	5	5
103	6	103	1	1
104	6	104	1	2
105	6	105	1	3
106	6	106	1	4
107	6	107	1	5
108	6	108	2	1
109	6	109	2	2
110	6	110	2	3
111	6	111	2	4
112	6	112	2	5
113	6	113	3	1
114	6	114	3	2
115	6	115	3	3
116	6	116	3	4
117	6	117	3	5
118	6	118	4	1
119	6	119	4	2
120	6	120	4	3
121	6	121	4	4
122	6	122	4	5
123	6	123	5	1
124	6	124	5	2
125	6	125	5	3
126	6	126	5	4
127	6	127	5	5
128	7	128	1	1
129	7	129	1	2
130	7	130	1	3
131	7	131	1	4
132	7	132	1	5
133	7	133	2	1
134	7	134	2	2
135	7	135	2	3
136	7	136	2	4
137	7	137	2	5
138	7	138	3	1
139	7	139	3	2
140	7	140	3	3
141	7	141	3	4
142	7	142	3	5
143	7	143	4	1
144	7	144	4	2
145	7	145	4	3
146	7	146	4	4
147	7	147	4	5
148	7	148	5	1
149	7	149	5	2
150	7	150	5	3
151	7	151	5	4
152	7	152	5	5
153	8	153	1	1
154	8	154	1	2
155	8	155	1	3
156	8	156	1	4
157	8	157	1	5
158	8	158	2	1
159	8	159	2	2
160	8	160	2	3
161	8	161	2	4
162	8	162	2	5
163	8	163	3	1
164	8	164	3	2
165	8	165	3	3
166	8	166	3	4
167	8	167	3	5
168	8	168	4	1
169	8	169	4	2
170	8	170	4	3
171	8	171	4	4
172	8	172	4	5
173	8	173	5	1
174	8	174	5	2
175	8	175	5	3
176	8	176	5	4
177	8	177	5	5
178	9	178	1	1
179	9	179	1	2
180	9	180	1	3
181	9	181	1	4
182	9	182	1	5
183	9	183	2	1
184	9	184	2	2
185	9	185	2	3
186	9	186	2	4
187	9	187	2	5
188	9	188	3	1
189	9	189	3	2
190	9	190	3	3
191	9	191	3	4
192	9	192	3	5
193	9	193	4	1
194	9	194	4	2
195	9	195	4	3
196	9	196	4	4
197	9	197	4	5
198	9	198	5	1
199	9	199	5	2
200	9	200	5	3
201	9	201	5	4
202	9	202	5	5
203	10	203	1	1
204	10	204	1	2
205	10	205	1	3
206	10	206	1	4
207	10	207	1	5
208	10	208	2	1
209	10	209	2	2
210	10	210	2	3
211	10	211	2	4
212	10	212	2	5
213	10	213	3	1
214	10	214	3	2
215	10	215	3	3
216	10	216	3	4
217	10	217	3	5
218	10	218	4	1
219	10	219	4	2
220	10	220	4	3
221	10	221	4	4
222	10	222	4	5
223	10	223	5	1
224	10	224	5	2
225	10	225	5	3
226	10	226	5	4
227	10	227	5	5
228	11	228	1	1
229	11	229	1	2
230	11	230	1	3
231	11	231	1	4
232	11	232	1	5
233	11	233	2	1
234	11	234	2	2
235	11	235	2	3
236	11	236	2	4
237	11	237	2	5
238	11	238	3	1
239	11	239	3	2
240	11	240	3	3
241	11	241	3	4
242	11	242	3	5
243	11	243	4	1
244	11	244	4	2
245	11	245	4	3
246	11	246	4	4
247	11	247	4	5
248	11	248	5	1
249	11	249	5	2
250	11	250	5	3
251	11	251	5	4
252	11	252	5	5
253	12	253	1	1
254	12	254	1	2
255	12	255	1	3
256	12	256	1	4
257	12	257	1	5
258	12	258	2	1
259	12	259	2	2
260	12	260	2	3
261	12	261	2	4
262	12	262	2	5
263	12	263	3	1
264	12	264	3	2
265	12	265	3	3
266	12	266	3	4
267	12	267	3	5
268	12	268	4	1
269	12	269	4	2
270	12	270	4	3
271	12	271	4	4
272	12	272	4	5
273	12	273	5	1
274	12	274	5	2
275	12	275	5	3
276	12	276	5	4
277	12	277	5	5
278	13	278	1	1
279	13	279	1	2
280	13	280	1	3
281	13	281	1	4
282	13	282	1	5
283	13	283	2	1
284	13	284	2	2
285	13	285	2	3
286	13	286	2	4
287	13	287	2	5
288	13	288	3	1
289	13	289	3	2
290	13	290	3	3
291	13	291	3	4
292	13	292	3	5
293	13	293	4	1
294	13	294	4	2
295	13	295	4	3
296	13	296	4	4
297	13	297	4	5
298	13	298	5	1
299	13	299	5	2
300	13	300	5	3
301	13	301	5	4
302	13	302	5	5
303	14	303	1	1
304	14	304	1	2
305	14	305	1	3
306	14	306	1	4
307	14	307	1	5
308	14	308	2	1
309	14	309	2	2
310	14	310	2	3
311	14	311	2	4
312	14	312	2	5
313	14	313	3	1
314	14	314	3	2
315	14	315	3	3
316	14	316	3	4
317	14	317	3	5
318	14	318	4	1
319	14	319	4	2
320	14	320	4	3
321	14	321	4	4
322	14	322	4	5
323	14	323	5	1
324	14	324	5	2
325	14	325	5	3
326	14	326	5	4
327	14	327	5	5
328	15	328	1	1
329	15	329	1	2
330	15	330	1	3
331	15	331	1	4
332	15	332	1	5
333	15	333	2	1
334	15	334	2	2
335	15	335	2	3
336	15	336	2	4
337	15	337	2	5
338	15	338	3	1
339	15	339	3	2
340	15	340	3	3
341	15	341	3	4
342	15	342	3	5
343	15	343	4	1
344	15	344	4	2
345	15	345	4	3
346	15	346	4	4
347	15	347	4	5
348	15	348	5	1
349	15	349	5	2
350	15	350	5	3
351	15	351	5	4
352	15	352	5	5
353	16	353	1	1
354	16	354	1	2
355	16	355	1	3
356	16	356	1	4
357	16	357	1	5
358	16	358	2	1
359	16	359	2	2
360	16	360	2	3
361	16	361	2	4
362	16	362	2	5
363	16	363	3	1
364	16	364	3	2
365	16	365	3	3
366	16	366	3	4
367	16	367	3	5
368	16	368	4	1
369	16	369	4	2
370	16	370	4	3
371	16	371	4	4
372	16	372	4	5
373	16	373	5	1
374	16	374	5	2
375	16	375	5	3
376	16	376	5	4
377	16	377	5	5
378	17	378	1	1
379	17	379	1	2
380	17	380	1	3
381	17	381	1	4
382	17	382	1	5
383	17	383	2	1
384	17	384	2	2
385	17	385	2	3
386	17	386	2	4
387	17	387	2	5
388	17	388	3	1
389	17	389	3	2
390	17	390	3	3
391	17	391	3	4
392	17	392	3	5
393	17	393	4	1
394	17	394	4	2
395	17	395	4	3
396	17	396	4	4
397	17	397	4	5
398	17	398	5	1
399	17	399	5	2
400	17	400	5	3
401	17	401	5	4
402	17	402	5	5
\.


--
-- Name: squares_square_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('squares_square_id_seq', 402, true);


--
-- Data for Name: squareusers; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY squareusers (squ_id, square_id, user_id, book_id) FROM stdin;
1	2	1	2
2	1	2	1
3	3	1	3
4	23	3	4
5	78	1	4
6	83	1	4
7	88	1	4
8	3	3	3
9	8	1	4
10	13	1	4
11	18	1	4
12	23	1	4
13	153	4	4
14	188	5	5
15	198	5	4
16	193	5	6
17	183	5	3
18	178	1	7
19	184	1	8
20	178	2	9
21	203	5	3
22	178	5	3
23	182	5	10
24	181	5	11
25	180	5	12
26	179	1	13
27	196	1	14
28	179	2	15
29	228	5	3
30	253	5	3
31	179	5	3
32	278	5	4
33	184	5	4
34	189	5	4
35	194	5	4
36	199	5	4
37	191	5	16
38	192	5	17
39	328	1	18
40	334	1	19
41	346	1	20
42	328	2	9
43	329	2	21
44	332	7	22
45	331	7	3
46	330	7	12
47	329	7	23
48	383	7	24
49	328	7	7
50	353	7	4
51	371	7	20
52	377	7	25
53	359	7	19
\.


--
-- Name: squareusers_squ_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('squareusers_squ_id_seq', 53, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, email, password, first_name, last_name) FROM stdin;
1	fake@email.com	secretpassword	Jess	Books
2	slayer@sunnydale.com	123	Buffy	Summers
3	ray@ray.com	password	Ray	Ziai
4	alec@fake.com	password	Alec	Foster
5	demo@hackbright.com	password	Demo	Hackbright
6	johndoe@gmail.com	12345	John	Doe
7	jane@austen.com	password	Jane	Austen
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 7, true);


--
-- Name: boards_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY boards
    ADD CONSTRAINT boards_pkey PRIMARY KEY (board_id);


--
-- Name: boardusers_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY boardusers
    ADD CONSTRAINT boardusers_pkey PRIMARY KEY (bu_id);


--
-- Name: bookgenres_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY bookgenres
    ADD CONSTRAINT bookgenres_pkey PRIMARY KEY (bg_id);


--
-- Name: books_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (book_id);


--
-- Name: genres_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- Name: squares_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squares
    ADD CONSTRAINT squares_pkey PRIMARY KEY (square_id);


--
-- Name: squareusers_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squareusers
    ADD CONSTRAINT squareusers_pkey PRIMARY KEY (squ_id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: boardusers_board_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY boardusers
    ADD CONSTRAINT boardusers_board_id_fkey FOREIGN KEY (board_id) REFERENCES boards(board_id);


--
-- Name: boardusers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY boardusers
    ADD CONSTRAINT boardusers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: bookgenres_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY bookgenres
    ADD CONSTRAINT bookgenres_book_id_fkey FOREIGN KEY (book_id) REFERENCES books(book_id);


--
-- Name: bookgenres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY bookgenres
    ADD CONSTRAINT bookgenres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES genres(genre_id);


--
-- Name: squares_board_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squares
    ADD CONSTRAINT squares_board_id_fkey FOREIGN KEY (board_id) REFERENCES boards(board_id);


--
-- Name: squares_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squares
    ADD CONSTRAINT squares_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES genres(genre_id);


--
-- Name: squareusers_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squareusers
    ADD CONSTRAINT squareusers_book_id_fkey FOREIGN KEY (book_id) REFERENCES books(book_id);


--
-- Name: squareusers_square_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squareusers
    ADD CONSTRAINT squareusers_square_id_fkey FOREIGN KEY (square_id) REFERENCES squares(square_id);


--
-- Name: squareusers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY squareusers
    ADD CONSTRAINT squareusers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

