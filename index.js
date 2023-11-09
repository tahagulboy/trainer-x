import React, { useState } from "react";

function AnaSayfa() {
  const [isim, setIsim] = useState("");
  const [yas, setYas] = useState(0);
  const [kilo, setKilo] = useState(0);
  const [boy, setBoy] = useState(0);
  const [hedef, setHedef] = useState("");

  const formSubmitHandler = (event) => {
    event.preventDefault();

    // Kullanıcı bilgilerini al
    const formData = new FormData(event.target);
    const formIsim = formData.get("isim");
    const formYas = formData.get("yas");
    const formKilo = formData.get("kilo");
    const formBoy = formData.get("boy");
    const formHedef = formData.get("hedef");

    // Kullanıcı bilgilerini set et
    setIsim(formIsim);
    setYas(formYas);
    setKilo(formKilo);
    setBoy(formBoy);
    setHedef(formHedef);

    // Fitness programını oluştur
    const fitnessProgrami = generateFitnessProgrami(isim, yas, kilo, boy, hedef);

    // Kullanıcıyı fitness programı sayfasına yönlendir
    window.location.href = "/fitness-programi";
  };

  return (
    <div className="container">
      <h1>Fitness Programı</h1>
      <form onSubmit={formSubmitHandler}>
        <div className="form-group">
          <label for="isim">Adınız:</label>
          <input
            type="text"
            className="form-control"
            id="isim"
            name="isim"
            value={isim}
            onChange={(event) => setIsim(event.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label for="yas">Yaşınız:</label>
          <input
            type="number"
            className="form-control"
            id="yas"
            name="yas"
            value={yas}
            onChange={(event) => setYas(event.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label for="kilo">Kilonuz:</label>
          <input
            type="number"
            className="form-control"
            id="kilo"
            name="kilo"
            value={kilo}
            onChange={(event) => setKilo(event.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label for="boy">Boyunuz:</label>
          <input
            type="number"
            className="form-control"
            id="boy"
            name="boy"
            value={boy}
            onChange={(event) => setBoy(event.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label for="hedef">Hedefiniz:</label>
          <select
            className="form-control"
            id="hedef"
            name="hedef"
            value={hedef}
            onChange={(event) => setHedef(event.target.value)}
            required
          >
            <option value="kilo-vermek">Kilo Vermek</option>
            <option value="kas-yapmak">Kas Yapmak</option>
            <option value="fit-olmak">Fit Olmak</option>
          </select>
        </div>
        <button type="submit" className="btn btn-primary">Fitness Programını Oluştur</button>
      </form>

function generateFitnessProgrami(isim, yas, kilo, boy, hedef) {
  // Hedefe göre program oluşturun
  switch (hedef) {
    case "kilo-vermek":
      return {
        pazartesi: ["1 saat koşu", "30 dakika ağırlık çalışması"],
        sali: ["30 dakika yoga", "30 dakika kardiyo"],
        carsamba: ["Dinlenme"],
        persembe: ["30 dakika yüzme", "30 dakika pilates"],
        cuma: ["1 saat bisiklet", "30 dakika serbest ağırlık çalışması"],
        cumartesi: ["30 dakika dans", "30 dakika yoga"],
        pazar: ["Dinlenme"],
      };
    case "kas-yapmak":
      return {
        pazartesi: ["1 saat ağırlık çalışması"],
        sali: ["30 dakika yoga", "30 dakika kardiyo"],
        carsamba: ["Dinlenme"],
        persembe: ["30 dakika yüzme", "30 dakika pilates"],
        cuma: ["1 saat ağırlık çalışması"],
        cumartesi: ["30 dakika serbest ağırlık çalışması", "30 dakika kardiyo"],
        pazar: ["Dinlenme"],
      };
    case "fit-olmak":
      return {
        pazartesi: ["30 dakika koşu", "30 dakika ağırlık çalışması"],
        sali: ["30 dakika yoga", "30 dakika kardiyo"],
        carsamba: ["Dinlenme"],
        persembe: ["30 dakika yüzme", "30 dakika pilates"],
        cuma: ["1 saat bisiklet", "30 dakika serbest ağırlık çalışması"],
        cumartesi: ["30 dakika dans", "30 dakika yoga"],
        pazar: ["30 dakika koşu", "30 dakika kardiyo"],
      };
    default:
      return null;
  }
}
    </div>
  );
}

export default AnaSayfa;
