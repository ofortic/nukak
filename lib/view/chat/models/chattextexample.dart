class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "Fortich",
    lastMessage: "Habla que",
    image: "assets/images/logo2nukak.png",
    time: "hace 3 min",
    isActive: false,
  ),
  Chat(
    name: "Jairo",
    lastMessage: "Cuentamelo todo",
    image: "assets/images/logo2nukak.png",
    time: "Hace 2 horas",
    isActive: true,
  ),
  Chat(
    name: "Samuel",
    lastMessage: "Mi vale que",
    image: "assets/images/logo2nukak.png",
    time: "Hace 30 min",
    isActive: false,
  ),
  Chat(
    name: "Rocio",
    lastMessage: "Van bien mis llaves",
    image: "assets/images/logo2nukak.png",
    time: "Hace 2 min",
    isActive: true,
  ),
  Chat(
    name: "Wilson",
    lastMessage: "Me gusta esta vaina",
    image: "assets/images/logo2nukak.png",
    time: "Hace 1 día",
    isActive: false,
  ),
  Chat(
    name: "Uninorte",
    lastMessage: "Esto está genial, tomen su cartón",
    image: "assets/images/logo2nukak.png",
    time: "Hace 2 días",
    isActive: false,
  ),
];
