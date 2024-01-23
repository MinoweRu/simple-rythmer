import processing.video.*;//動画読み込みライブラリ　http://blog.livedoor.jp/reona396/archives/55770386.html

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
// ↑ 音源を読み込むライブラリ

Minim minim;

Movie Demoplay;//デモ映像の読み込み用

AudioSample easy;// 音声波形を作るための数字　→ https://r-dimension.xsrv.jp/classes_j/minim/
AudioSample se1;
AudioPlayer TITLE;
AudioSample hard;
AudioSample se2;
AudioPlayer se21;
int waveH = 100; //波の大きさ

String scene = "start_1";//スタート画面に設定

// ↓ノーツの制御 →参考 https://qiita.com/NOEL_404_/items/14286200d4ff286b28a1
int[]noteC = new int[]{0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, };// ♪
int[]noteV = new int[]{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, };// ♪
int[]noteB = new int[]{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, };// ♪
int[]noteN = new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, };// ♪
float[] noteC_y = new float[120]; //ノーツの座標を決める
float[] noteV_y = new float[120];
float[] noteB_y = new float[120];
float[] noteN_y = new float[120];
int noteC_x = -300; //ノーツの座標を決める
int noteV_x = -100;
int noteB_x = 100;
int noteN_x = 300;
int note_size_c[] = new int [120];//ノーツの大きさを決める...打たれたときに大きさを0にすることで消えたように見せる
int note_size_v[] = new int [120];
int note_size_b[] = new int [120];
int note_size_n[] = new int [120];

//↓ hard の譜面
int[]noteC_ = new int[]{0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, };// ♪
int[]noteV_ = new int[]{0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, };// ♪
int[]noteB_ = new int[]{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, };// ♪
int[]noteN_ = new int[]{0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, };// ♪
float[] noteC_y_ = new float[180]; //ノーツの座標を決める
float[] noteV_y_ = new float[180];
float[] noteB_y_ = new float[180];
float[] noteN_y_ = new float[180];
int note_size_c_[] = new int [180];//ノーツの大きさを決める...打たれたときに大きさを0にすることで消えたように見せる
int note_size_v_[] = new int [180];
int note_size_b_[] = new int [180];
int note_size_n_[] = new int [180];
//↑ hard の譜面


//スコアデータ管理
int score = 0;
JSONObject score_data_easy;//スコア保存ファイル https://detail.chiebukuro.yahoo.co.jp/qa/question_detail/q13227294213
JSONObject highscore_data_easy;
int high = 0;
int now = 0;
JSONObject score_data_hard;//スコア保存ファイル https://detail.chiebukuro.yahoo.co.jp/qa/question_detail/q13227294213
JSONObject highscore_data_hard;
int high_ = 0;
int now_ = 0;

int trns_2 = 0;  //スタート画面の矢印制御
int arrow_y = 205;
int note_trigger = 0;

color black, blue, green;//カラーパレット

PImage title; //画像ふぁいる読み込み
PImage title_ui_1;
PImage title_ui_2;
PImage arrow;
PImage C;
PImage V;
PImage B;
PImage N;
PImage Cp;
PImage Vp;
PImage Bp;
PImage Np;
PImage GameBack;
PImage MusicStart;
PImage scorebord;
PImage note;
PImage great;
PImage good;
PImage ok;
PImage demoplay;
PImage finish;
PImage result;
PImage result_h;

boolean left, right, up, down, space, c, v, b, n; // C++ の boolと一緒
// キーの同時押しの判定に使ったりする → https://qiita.com/dqn/items/fd67704045fe9a02dd1f

void setup() {
  size(1280, 720);  //サイズ決定
  Demoplay = new Movie(this, "demoplay.mp4");//動画ファイル
  Demoplay.loop();
  minim = new Minim(this); //音声ファイル
  easy = minim.loadSample("easy.wav", 1024);// 1024は音量の分割数を決めている 
  hard = minim.loadSample("hard.wav", 1024);// 1024は音量の分割数を決めている 
  TITLE = minim.loadFile("title.wav");
  se1 = minim.loadSample("se1.wav");
  se2 = minim.loadSample("se2.wav");
  se21 = minim.loadFile("se2.wav");
  score_data_easy = new JSONObject();//json file 外部のファイルに数値のデータを保存する
  highscore_data_easy = new JSONObject();
  highscore_data_easy.setInt("highscore_data_easy", high);
  saveJSONObject(highscore_data_easy, "highscore_data_easy.json");
  score_data_hard = new JSONObject();//json file 外部のファイルに数値のデータを保存する
  highscore_data_hard = new JSONObject();
  highscore_data_hard.setInt("highscore_data_hard", high_);
  saveJSONObject(highscore_data_hard, "highscore_data_hard.json");
  frameRate(30);
  rectMode(CENTER);
  black = color(40, 40, 44); //色のデータ保存
  blue  = color(38, 115, 184);
  green = color(142, 227, 200);
  title = loadImage("title.png");       //画像データ読み込み
  title_ui_1 = loadImage("press space key.png");
  title_ui_2 = loadImage("select difficulty.png");
  arrow = loadImage("right.png");
  C = loadImage("c.png");
  V = loadImage("v.png");
  B = loadImage("b.png");
  N = loadImage("n.png");
  Cp = loadImage("c_p.png");
  Vp = loadImage("v_p.png");
  Bp = loadImage("b_p.png");
  Np = loadImage("n_p.png");
  GameBack = loadImage("gameback.png");
  MusicStart = loadImage("music start.png");
  scorebord = loadImage("scorebord.png");
  great = loadImage("great.png");
  good = loadImage("good.png");
  ok = loadImage("ok.png");
  note = loadImage("note.png");
  demoplay = loadImage("demoplay.png");
  finish = loadImage("finish.png");
  result = loadImage("resultbord.png");
  result_h = loadImage("resultbord_high.png");
  for (int i=0; i<120; i++) {// ♪ 配置
    noteC_y[i] = (-385 + -i*150);//ノーツを配置
    noteV_y[i] = (-385 + -i*150);
    noteB_y[i] = (-385 + -i*150);
    noteN_y[i] = (-385 + -i*150);
  }
  for (int i=0; i<180; i++) {// ♪ 配置
    noteC_y_[i] = (-385 + -i*100);//ノーツを配置
    noteV_y_[i] = (-385 + -i*100);
    noteB_y_[i] = (-385 + -i*100);
    noteN_y_[i] = (-385 + -i*100);
  }
  for (int i=0; i<120; i++) {
    note_size_c[i] = 195;     //ノーツの大きさを決める
    note_size_v[i] = 195;
    note_size_b[i] = 195;
    note_size_n[i] = 195;
  }
  for (int i=0; i<180; i++) {
    note_size_c_[i] = 195;     //ノーツの大きさを決める
    note_size_v_[i] = 195;
    note_size_b_[i] = 195;
    note_size_n_[i] = 195;
  }
}

//キー押し判定
void keyPressed() {
  if (keyCode == LEFT)  left  = true;
  if (keyCode == RIGHT) right = true;
  if (keyCode == UP)    up    = true;
  if (keyCode == DOWN)  down  = true;
  if (key == 'c')       c     = true;
  if (key == 'v')       v     = true;
  if (key == 'b')       b     = true;
  if (key == 'n')       n     = true;
  if (key == ' ')        space = true;
}

void keyReleased() {
  if (keyCode == LEFT)  left  = false;
  if (keyCode == RIGHT) right = false;
  if (keyCode == UP)    up    = false;
  if (keyCode == DOWN)  down  = false;
  if (key == 'c')       c     = false;
  if (key == 'v')       v     = false;
  if (key == 'b')       b     = false;
  if (key == 'n')       n     = false;
  if (key == ' ')        space = false;
}

void draw() {//それぞれのゲーム画面を分ける
  background(black);
  if (scene == "start_1") start_scene_1();//開始画面
  else if (scene == "start_2") start_scene_2(); //難易度選択画面

  else if (scene == "game_easy_start") game_scene_easy_start();//曲はじめ画面
  else if (scene == "game_easy") game_scene_easy();//ゲームプレイ画面
  else if (scene == "game_easy_end") game_scene_easy_end();

  else if (scene == "game_hard_start") game_scene_hard_start();//曲はじめ画面
  else if (scene == "game_hard") game_scene_hard();//ゲームプレイ画面
  else if (scene == "game_hard_end") game_scene_hard_end();//リザルト画面
}


void start_scene_1() {
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  translate(width/2, height/2);
  int trns_1 = 255;// 画像の府透明度
  background(black);
  image(Demoplay, 0, 0);//でもプレイ画像を配置
  if (frameCount == 1) {
    TITLE.loop();//音声をループ
  }
  image(title, 0, 0);// ロゴ画像貼り付け
  tint(255, trns_1);
  image(title_ui_1, 0, 0); // "press space key" を描画
  noTint();
  if (space == true) {//次のシーンへ移動
    scene = "start_2";
    space = false;
  }
}


void start_scene_2() {
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  translate(width/2, height/2);
  background(black);
  image(Demoplay, 0, 0);//デモプレイ画像を再配置

  image(title, 0, 0);// ロゴ再配置
  trns_2 = 255;// 画像の府透明度
  tint(255, trns_2);
  image(title_ui_2, 0, 0);
  noTint();
  if (keyCode == UP) {//十字キーで選択するときの制御
    arrow_y = 205;
  }
  if (keyCode == DOWN) {
    arrow_y = 275;
  }
  if (up == true || down == true) {
    se1.trigger();
    up = false;
    down = false;
  }
  image(arrow, -150, arrow_y, 50, 50);
  if (space == true) {//次のシーンへ移動
    if (arrow_y == 205) {
      arrow_y = 205;
      TITLE.pause();
      scene = "game_easy_start";
    }
    if (arrow_y == 275) {
      arrow_y = 275;
      TITLE.pause();
      scene = "game_hard_start";
    }
    space = false;
  }
}

void game_scene_easy_start() {//ゲーム画面
  background(40, 40, 44);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  translate(width/2, height/2);
  image(GameBack, 0, 0);
  image(MusicStart, 0, 0);
  image(C, 0, 0);
  image(V, 0, 0);
  image(B, 0, 0);
  image(N, 0, 0);
  image(scorebord, 0, -640);
  textSize(40);
  fill(255, 150);
  text(score, 0, -324);
  if (c == true) {
    image(Cp, 0, 0);
    se2.trigger();
    c = false;
  }
  if (v == true) {
    image(Vp, 0, 0);
    se2.trigger();
    v = false;
  }
  if (b == true) {
    image(Bp, 0, 0);
    se2.trigger();
    b = false;
  }
  if (n == true) {
    image(Np, 0, 0);
    se2.trigger();
    n = false;
  }
  //スコアやノーツの一を初期化
  if (space == true) {
    scene = "game_easy";
    space = false;
    easy.trigger();
    for (int i=0; i<120; i++) {// ♪ haichi
      noteC_y[i] = (-385 + -i*150);//note haichi
      noteV_y[i] = (-385 + -i*150);
      noteB_y[i] = (-385 + -i*150);
      noteN_y[i] = (-385 + -i*150);
    }
    for (int i=0; i<120; i++) {
      note_size_c[i] = 195;
      note_size_v[i] = 195;
      note_size_b[i] = 195;
      note_size_n[i] = 195;
    }
    score = 0;
  }
}

void game_scene_easy() {//ゲーム画面
  background(40, 40, 44);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  translate(width/2, height/2);
  image(GameBack, 0, 0);
  stroke(255);
  for (int i = 0; i < easy.left.size()-1; i++) {
    point(-550 + easy.left.get(i)*waveH, i-360);  //1024ko ni bunnkatu sareta otowo narabeteru
    point(550 + easy.right.get(i)*waveH, i-360);
  }
  noStroke();
  image(C, 0, 0);
  image(V, 0, 0);
  image(B, 0, 0);
  image(N, 0, 0);
  if (c == true) {
    image(Cp, 0, 0);
  }
  if (v == true) {
    image(Vp, 0, 0);
  }
  if (b == true) {
    image(Bp, 0, 0);
  }
  if (n == true) {
    image(Np, 0, 0);
  }
  // collision detaction C
  for (int i=0; i<104; i++) {
    noteC_y[i] += 20; // notes no hayasa
    if (noteC[i]==1) {
      image(note, noteC_x, noteC_y[i], note_size_c[i], note_size_c[i]);
      if (205 < noteC_y[i] && noteC_y[i] < 225) {//  1fps gosa no tokutenn
        if (c == true) {
          image(Cp, 0, 0);
          se2.trigger();
          image(great, -300, 0);
          note_size_c[i] = 0;
          score += 10;
          c =false;
        }
      } else if (185 < noteC_y[i] && noteC_y[i] < 245) {//  3fps gosa no tokutenn
        if (c == true) {
          image(Cp, 0, 0);
          se2.trigger();
          image(good, -300, 0);
          note_size_c[i] = 0;
          score += 5;
          c =false;
        }
      } else if (165 < noteC_y[i] && noteC_y[i] < 265) {//  3fps gosa no tokutenn
        if (c == true) {
          image(Cp, 0, 0);
          se2.trigger();
          image(ok, -300, 0);
          note_size_c[i] = 0;
          score += 2;
          c =false;
        }
      }
    }
  }
  // collision detaction V
  for (int i=0; i<104; i++) {
    noteV_y[i] += 20; // notes no hayasa
    if (noteV[i]==1) {
      image(note, noteV_x, noteV_y[i], note_size_v[i], note_size_v[i]);
      if (205 < noteV_y[i] && noteV_y[i] < 225) {//  1fps gosa no tokutenn
        if (v == true) {
          image(Vp, 0, 0);
          se2.trigger();
          image(great, -100, 0);
          note_size_v[i] = 0;
          score += 10;
          v =false;
        }
      } else if (185 < noteV_y[i] && noteV_y[i] < 245) {//  3fps gosa no tokutenn
        if (v == true) {
          image(Vp, 0, 0);
          se2.trigger();
          image(good, -100, 0);
          note_size_v[i] = 0;
          score += 5;
          v =false;
        }
      } else if (165 < noteV_y[i] && noteV_y[i] < 265) {//  3fps gosa no tokutenn
        if (v == true) {
          image(Vp, 0, 0);
          se2.trigger();
          image(ok, -100, 0);
          note_size_v[i] = 0;
          score += 2;
          v =false;
        }
      }
    }
  }
  // collision detaction B
  for (int i=0; i<104; i++) {
    noteB_y[i] += 20; // notes no hayasa
    if (noteB[i]==1) {
      image(note, noteB_x, noteB_y[i], note_size_b[i], note_size_b[i]);
      if (205 < noteB_y[i] && noteB_y[i] < 225) {//  1fps gosa no tokutenn
        if (b == true) {
          image(Bp, 0, 0);
          se2.trigger();
          image(great, 100, 0);
          note_size_b[i] = 0;
          score += 10;
          b =false;
        }
      } else if (185 < noteB_y[i] && noteB_y[i] < 245) {//  3fps gosa no tokutenn
        if (b == true) {
          image(Bp, 0, 0);
          se2.trigger();
          image(good, 100, 0);
          note_size_b[i] = 0;
          score += 5;
          b =false;
        }
      } else if (165 < noteB_y[i] && noteB_y[i] < 265) {//  3fps gosa no tokutenn
        if (b == true) {
          image(Bp, 0, 0);
          se2.trigger();
          image(ok, 100, 0);
          note_size_b[i] = 0;
          score += 2;
          b =false;
        }
      }
    }
  }
  // collision detaction N
  for (int i=0; i<104; i++) {
    noteN_y[i] += 20; // notes no hayasa
    if (noteN[i]==1) {
      image(note, noteN_x, noteN_y[i], note_size_n[i], note_size_n[i]);
      if (205 < noteN_y[i] && noteN_y[i] < 225) {//  1fps gosa no tokutenn
        if (n == true) {
          image(Np, 0, 0);
          se2.trigger();
          image(great, 300, 0);
          note_size_n[i] = 0;
          score += 10;
          n =false;
        }
      } else if (185 < noteN_y[i] && noteN_y[i] < 245) {//  3fps gosa no tokutenn
        if (n == true) {
          image(Np, 0, 0);
          se2.trigger();
          image(good, 300, 0);
          note_size_n[i] = 0;
          score += 5;
          n =false;
        }
      } else if (165 < noteN_y[i] && noteN_y[i] < 265) {//  3fps gosa no tokutenn
        if (n == true) {
          image(Np, 0, 0);
          se2.trigger();
          image(ok, 300, 0);
          note_size_n[i] = 0;
          score += 2;
          n =false;
        }
      }
    }
  }
  image(scorebord, 0, -640);
  textSize(40);
  fill(255, 150);
  text(score, 0, -324);
  noFill();
  if (c == true) {
    image(Cp, 0, 0);
    se2.trigger();
  }
  if (v == true) {
    image(Vp, 0, 0);
    se2.trigger();
  }
  if (b == true) {
    image(Bp, 0, 0);
    se2.trigger();
  }
  if (n == true) {
    image(Np, 0, 0);
    se2.trigger();
  }
  if (noteN_y[101] > 215 + 600) {
    image(finish, 0, 0);
  }
  if (noteN_y[101] > 215 + 3600) {
    scene = "game_easy_end";
    score_data_easy.setInt("score_data_easy", score);
    saveJSONObject(score_data_easy, "score_data_easy.json");
  }
}

void game_scene_easy_end() {//ゲーム画面
  background(40, 40, 44);
  translate(width/2, height/2);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  score_data_easy = loadJSONObject("score_data_easy.json");
  highscore_data_easy = loadJSONObject("highscore_data_easy.json");
  now = score_data_easy.getInt("score_data_easy");
  high = highscore_data_easy.getInt("highscore_data_easy");
  if (now < high) {//ハイスコアに及ばなかったとき
    image(result, 0, 0);
    fill(255);
    noStroke();
    textSize(200);
    text(now, 0, -30);
    textSize(60);
    text(high, 411, 260);
  }
  if (now > high || now == high) {//ハイスコアを更新したとき
    image(result_h, 0, 0);
    fill(255);
    noStroke();
    textSize(200);
    text(now, 0, -30);
    textSize(60);
    text(now, 411, 260);
    highscore_data_easy.setInt("highscore_data_easy", now);
    saveJSONObject(highscore_data_easy, "highscore_data_easy.json");
  }
  if (space == true) {
    TITLE.loop();//loop saisei
    scene = "start_1";
    space = false;
  }
}


void game_scene_hard_start() {//ゲーム画面
  background(40, 40, 44);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  translate(width/2, height/2);
  image(GameBack, 0, 0);
  image(MusicStart, 0, 0);
  image(C, 0, 0);
  image(V, 0, 0);
  image(B, 0, 0);
  image(N, 0, 0);
  image(scorebord, 0, -640);
  textSize(40);
  fill(255, 150);
  text(score, 0, -324);
  if (c == true) {
    image(Cp, 0, 0);
    se2.trigger();
    c = false;
  }
  if (v == true) {
    image(Vp, 0, 0);
    se2.trigger();
    v = false;
  }
  if (b == true) {
    image(Bp, 0, 0);
    se2.trigger();
    b = false;
  }
  if (n == true) {
    image(Np, 0, 0);
    se2.trigger();
    n = false;
  }
  if (space == true) {
    scene = "game_hard";
    space = false;
    hard.trigger();
    for (int i=0; i<180; i++) {// ♪ haichi
      noteC_y_[i] = (-385 + -i*100);//note haichi
      noteV_y_[i] = (-385 + -i*100);
      noteB_y_[i] = (-385 + -i*100);
      noteN_y_[i] = (-385 + -i*100);
    }
    for (int i=0; i<180; i++) {
      note_size_c_[i] = 195;
      note_size_v_[i] = 195;
      note_size_b_[i] = 195;
      note_size_n_[i] = 195;
    }
    score = 0;
  }
}

void game_scene_hard() {//ゲーム画面
  background(40, 40, 44);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  translate(width/2, height/2);
  image(GameBack, 0, 0);
  stroke(255);
  for (int i = 0; i < hard.left.size()-1; i++) {
    point(-550 + hard.left.get(i)*waveH, i-360);  //1024ko ni bunnkatu sareta otowo narabeteru
    point(550 + hard.right.get(i)*waveH, i-360);
  }
  noStroke();
  image(C, 0, 0);
  image(V, 0, 0);
  image(B, 0, 0);
  image(N, 0, 0);
  if (c == true) {
    image(Cp, 0, 0);
  }
  if (v == true) {
    image(Vp, 0, 0);
  }
  if (b == true) {
    image(Bp, 0, 0);
  }
  if (n == true) {
    image(Np, 0, 0);
  }
  // collision detaction C
  for (int i=0; i<180; i++) {
    noteC_y_[i] += 20; // notes no hayasa
    if (noteC_[i]==1) {
      image(note, noteC_x, noteC_y_[i], note_size_c_[i], note_size_c_[i]);
      if (205 < noteC_y_[i] && noteC_y_[i] < 225) {//  1fps gosa no tokutenn
        if (c == true) {
          image(Cp, 0, 0);
          se2.trigger();
          image(great, -300, 0);
          note_size_c_[i] = 0;
          score += 10;
          c =false;
        }
      } else if (185 < noteC_y_[i] && noteC_y_[i] < 245) {//  3fps gosa no tokutenn
        if (c == true) {
          image(Cp, 0, 0);
          se2.trigger();
          image(good, -300, 0);
          note_size_c_[i] = 0;
          score += 5;
          c =false;
        }
      } else if (165 < noteC_y_[i] && noteC_y_[i] < 265) {//  3fps gosa no tokutenn
        if (c == true) {
          image(Cp, 0, 0);
          se2.trigger();
          image(ok, -300, 0);
          note_size_c_[i] = 0;
          score += 2;
          c =false;
        }
      }
    }
  }
  // collision detaction V
  for (int i=0; i<180; i++) {
    noteV_y_[i] += 20; // notes no hayasa
    if (noteV_[i]==1) {
      image(note, noteV_x, noteV_y_[i], note_size_v_[i], note_size_v_[i]);
      if (205 < noteV_y_[i] && noteV_y_[i] < 225) {//  1fps gosa no tokutenn
        if (v == true) {
          image(Vp, 0, 0);
          se2.trigger();
          image(great, -100, 0);
          note_size_v_[i] = 0;
          score += 10;
          v =false;
        }
      } else if (185 < noteV_y_[i] && noteV_y_[i] < 245) {//  3fps gosa no tokutenn
        if (v == true) {
          image(Vp, 0, 0);
          se2.trigger();
          image(good, -100, 0);
          note_size_v_[i] = 0;
          score += 5;
          v =false;
        }
      } else if (165 < noteV_y_[i] && noteV_y_[i] < 265) {//  3fps gosa no tokutenn
        if (v == true) {
          image(Vp, 0, 0);
          se2.trigger();
          image(ok, -100, 0);
          note_size_v_[i] = 0;
          score += 2;
          v =false;
        }
      }
    }
  }
  // collision detaction B
  for (int i=0; i<180; i++) {
    noteB_y_[i] += 20; // notes no hayasa
    if (noteB_[i]==1) {
      image(note, noteB_x, noteB_y_[i], note_size_b_[i], note_size_b_[i]);
      if (205 < noteB_y_[i] && noteB_y_[i] < 225) {//  1fps gosa no tokutenn
        if (b == true) {
          image(Bp, 0, 0);
          se2.trigger();
          image(great, 100, 0);
          note_size_b_[i] = 0;
          score += 10;
          b =false;
        }
      } else if (185 < noteB_y_[i] && noteB_y_[i] < 245) {//  3fps gosa no tokutenn
        if (b == true) {
          image(Bp, 0, 0);
          se2.trigger();
          image(good, 100, 0);
          note_size_b_[i] = 0;
          score += 5;
          b =false;
        }
      } else if (165 < noteB_y_[i] && noteB_y_[i] < 265) {//  3fps gosa no tokutenn
        if (b == true) {
          image(Bp, 0, 0);
          se2.trigger();
          image(ok, 100, 0);
          note_size_b_[i] = 0;
          score += 2;
          b =false;
        }
      }
    }
  }
  // collision detaction N
  for (int i=0; i<180; i++) {
    noteN_y_[i] += 20; // notes no hayasa
    if (noteN_[i]==1) {
      image(note, noteN_x, noteN_y_[i], note_size_n_[i], note_size_n_[i]);
      if (205 < noteN_y_[i] && noteN_y_[i] < 225) {//  1fps gosa no tokutenn
        if (n == true) {
          image(Np, 0, 0);
          se2.trigger();
          image(great, 300, 0);
          note_size_n_[i] = 0;
          score += 10;
          n =false;
        }
      } else if (185 < noteN_y_[i] && noteN_y_[i] < 245) {//  3fps gosa no tokutenn
        if (n == true) {
          image(Np, 0, 0);
          se2.trigger();
          image(good, 300, 0);
          note_size_n_[i] = 0;
          score += 5;
          n =false;
        }
      } else if (165 < noteN_y_[i] && noteN_y_[i] < 265) {//  3fps gosa no tokutenn
        if (n == true) {
          image(Np, 0, 0);
          se2.trigger();
          image(ok, 300, 0);
          note_size_n_[i] = 0;
          score += 2;
          n =false;
        }
      }
    }
  }
  image(scorebord, 0, -640);
  textSize(40);
  fill(255, 150);
  text(score, 0, -324);
  noFill();
  if (c == true) {
    image(Cp, 0, 0);
    se2.trigger();
  }
  if (v == true) {
    image(Vp, 0, 0);
    se2.trigger();
  }
  if (b == true) {
    image(Bp, 0, 0);
    se2.trigger();
  }
  if (n == true) {
    image(Np, 0, 0);
    se2.trigger();
  }
  if (noteN_y_[179] > 215 + 600) {
    image(finish, 0, 0);
  }
  if (noteN_y_[179] > 215 + 3600) {
    scene = "game_hard_end";
    score_data_hard.setInt("score_data_hard", score);
    saveJSONObject(score_data_hard, "score_data_hard.json");
  }
}
void game_scene_hard_end() {//ゲーム画面
  background(40, 40, 44);
  translate(width/2, height/2);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  score_data_hard = loadJSONObject("score_data_hard.json");
  highscore_data_hard = loadJSONObject("highscore_data_hard.json");
  now_ = score_data_hard.getInt("score_data_hard");
  high_ = highscore_data_hard.getInt("highscore_data_hard");
  if (now_ < high_) {//ハイスコアに及ばなかったとき
    image(result, 0, 0);
    fill(255);
    noStroke();
    textSize(200);
    text(now_, 0, -30);
    textSize(60);
    text(high_, 411, 260);
  }
  if (now_ > high_ || now_ == high_) {//ハイスコアを更新したとき
    image(result_h, 0, 0);
    fill(255);
    noStroke();
    textSize(200);
    text(now_, 0, -30);
    textSize(60);
    text(now_, 411, 260);
    highscore_data_hard.setInt("highscore_data_hard", now_);
    saveJSONObject(highscore_data_hard, "highscore_data_hard.json");
  }
  if (space == true) {
    TITLE.loop();//loop saisei
    scene = "start_1";
    space = false;
  }
}

void movieEvent(Movie m) {//動画読み込み用
  m.read();
}
