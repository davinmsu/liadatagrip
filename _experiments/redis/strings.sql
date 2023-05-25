ping

set pipa 123

get pipa

-- nx установит только если значения еще не было
set pipa 25 nx

-- xx перезапишет
set pipa 25 xx

-- Если строку-значение можно считать как int, работает инкремент
-- race-condition free
incr pipa
incrby pipa 5



-- Присвоение и чтение сразу нескольких ключей
mset a 10 b 20 c 30
mget a b c

-- проверка и удаление ключа, тип значения
type a
exists c
del c

-- Установка времени жизни
expire a 5
set pupa 777 ex 50
ttl pupa


-- Списки. Реализованы как linked lists. Поэтому эффективны операции с концами
-- Для работы с массивами есть sorted sets
rpush mylist a
rpush mylist b c d e
lpush mylist hello
rpop mylist

-- wait for elements in the list mylist, but return if after 5 seconds no element is available
-- чтобы лишний раз не дергать пустой лист, если одновременно работают продьюсер и консьюмер
brpop mylist 5
-- обрезка списка
ltrim mylist 0 3
llen mylist

-- Отображение участка списка по индексам (здесь - всего)
lrange mylist 0 -1


-- Хеш-мапы
hset user:001 name ivan lastname dashkevich birthyear 1988 authorized 1
hget user:001 name
hgetall user:001
hincrby user:001 authorized 5


-- Sets

sadd myset 1 2 3
sadd myset 4000
smembers myset
sismember myset 4000
sadd news:1000:tags 1 2 5 77
smembers news:1000:tags

sadd tag:1:news 1000
sadd tag:2:news 1000
sadd tag:5:news 1000
sadd tag:77:news 1000

-- Поиск пересечений. Можно искать объединения и прочее
-- sunionstore например ищет объединение и сохраняет в новый сет
sinter tag:1:news tag:2:news


-- Sorted sets. Хранятся в порядке в соответствии со score.
-- score - float. Если скор одинаковый, первенство определяется лексиграфически по ключу

zadd hackers 1940 'Alan Kay'
zadd hackers 1957 'Sophie Wilson'
zadd hackers 1953 "Richard Stallman"
zadd hackers 1949 "Anita Borg"
zadd hackers 1965 "Yukihiro Matsumoto"
zadd hackers 1914 "Hedy Lamarr"
zadd hackers 1916 "Claude Shannon"
zadd hackers 1969 "Linus Torvalds"
zadd hackers 1912 "Alan Turing"

zrange hackers 0 -1 withscores
zrevrange hackers 0 -1 withscores
zrangebyscore hackers 1940 1960

zrangebylex hackers [B [P
-- таким образом, там можно хранить и числа, и брать диапазоны
-- Можно сортировать лексиграфически по ключу,
--  ZRANGEBYLEX, ZREVRANGEBYLEX, ZREMRANGEBYLEX and ZLEXCOUNT


-- bitmap. Хранятся фактически как строки
-- Создает битовую маску и автоматически удлинняет ее при необходимости
-- В данном случае у нас появилась строка на 10 бит с последним битом, равным 1
-- Удобно хранить и проверять флаги
setbit userflags 10 1
getbit userflags 10
setbit userflags 25 1
bitcount userflags
-- Работают битовые операции

bitpos userflags 0


-- HyperlogLogs
-- https://towardsdatascience.com/hyperloglog-a-simple-but-powerful-algorithm-for-data-scientists-aed50fe47869
-- Структура, позволяющая с точностью выше 99% определять число уников в наборе
-- За фиксированную (до 12кб) сложность по памяти

pfadd hll a b c d
pfcount hll


-- Geospatial
GEOADD locations:ca -122.27652 37.805186 station:1
GEOADD locations:ca -122.2674626 37.8062344 station:2
GEOADD locations:ca -122.2469854 37.8104049 station:3
GEOSEARCH locations:ca FROMLONLAT -122.2612767 37.7936847 BYRADIUS 5 km WITHDIST



















