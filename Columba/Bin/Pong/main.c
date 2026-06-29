#include "raylib.h"
#include <stdio.h>
//-----------------------ball

Vector2 ball_position = {300.0f, 400.0f};
int is_collide = 0;
Vector2 ball_velocity = {0.5f, 0.5f};
//-----------------------player 1
Vector2 position_player1 = {10.0f, 300.0f};
int score_p1 = 0;
char __score_p1[100];
//-----------------------player 2
Vector2 position_player2 = {780.0f, 300.0f};
int score_p2 = 0;
char __score_p2[100];
//-----------------------
int p1_up, p1_down, p2_up, p2_down;
float player_velocity = 0.75f;
char kill_cam = 0;
int game_pause = 0;
int main(void){
   
    SetTargetFPS(500);
    InitWindow(800, 600, "PING PONG - 2 players");
    InitAudioDevice();
    Sound hitSound = LoadSound("pong.mp3");
    while (!WindowShouldClose()) {
        BeginDrawing();
            ClearBackground(BLACK);
           
            
            
            sprintf(__score_p1, "%d", score_p1);
            DrawText("Score : ", 670, 20, 20, BLUE);
            DrawText(__score_p1, 750, 20, 20, BLUE);
            sprintf(__score_p2, "%d", score_p2);
            DrawText("Score : ", 20, 20, 20, RED);
            DrawText(__score_p2, 100, 20, 20, RED);


            DrawRectangle(position_player1.x, position_player1.y, 7, 70, RED);
            DrawRectangle(position_player2.x, position_player2.y, 7, 70, BLUE);
            
            DrawLine(400, 0, 400, 600, WHITE);
            
            //gestion des clavier player 1
            if(IsKeyPressed(KEY_W)){
                p1_up = 1;
                p1_down = 0;
            }else if(IsKeyPressed(KEY_S)){
                p1_down = 1;
                p1_up = 0;
            }
            //gestion clavier player 2
            if(IsKeyPressed(KEY_UP)){
                p2_up = 1;
                p2_down = 0;
            }else if(IsKeyPressed(KEY_DOWN)){
                p2_up = 0;
                p2_down = 1;
            }

            //Pplayer1
            if(p1_up){
                position_player1.y -= player_velocity;
            }else if(p1_down){
                position_player1.y += player_velocity;
            }
            //Pplayer2
            if(p2_up){
                position_player2.y -= player_velocity;
            }else if(p2_down){
                position_player2.y += player_velocity;
            }

            position_player2.y = ball_position.y;
            //--------------------------begin collision chequing
            if(position_player1.y <= 0){
                p1_up = 0;
            }
            if(position_player1.y >= 530){
                p1_down = 0;
            }

            if(position_player2.y <= 0){
                p2_up = 0;
            }
            if(position_player2.y >= 530){
                p2_down = 0;
            }
            //--------------------------end collision checking
            //-------------------------------------------------begin ball checking
            DrawCircle(ball_position.x, ball_position.y, 5, YELLOW);
       
            ball_position.x += ball_velocity.x;
            ball_position.y += ball_velocity.y;

            if(ball_position.y >= 600){
                ball_velocity.y = -1 * ball_velocity.y;
            }else if(ball_position.y <= 0){
                ball_velocity.y = -1 * ball_velocity.y;
            }
            
            //------- player pop and game over 
            
            

            if((ball_position.y >= position_player2.y - 70 && ball_position.y <= position_player2.y + 70) && ball_position.x >= 776){
                ball_velocity.y = 1 * ball_velocity.y;
                ball_velocity.x = -1 * ball_velocity.x;
                PlaySound(hitSound);
            }
            if((ball_position.y >= position_player1.y - 70 && ball_position.y <= position_player1.y + 70) && ball_position.x <= 13.5){
                ball_velocity.y = 1 * ball_velocity.y;
                ball_velocity.x = -1 * ball_velocity.x;
                PlaySound(hitSound);
            }
            if(ball_position.x <= 0){
                //
                score_p1  = score_p1 + 1;
                game_pause = 1;
                kill_cam = 'b';
            }
            if(ball_position.x >= 800){
                //
                score_p2 = score_p2 + 1;
                game_pause = 1;
                kill_cam = 'r';
            }
            //-------------------------------------------------game peuse and restart 
            if(game_pause){
                if(kill_cam == 'r'){
                    DrawText("Red +1 point ! ", 200, 300, 50, RED);
                }else if(kill_cam == 'b'){
                    DrawText("Blue +1 point ! ", 200, 300, 50, BLUE);
                }
                player_velocity = 0.0f;
                ball_position.x = 10;
                ball_position.y = -10;
                if(IsKeyPressed(KEY_ENTER)){
                    game_pause = 0;
                    ball_position.x = 400;
                    ball_position.y = 300;
                    //----player1
                    player_velocity = 0.75f;
                }
            }
            // Ici tu dessines tes points projetés
        EndDrawing();
        
    
    }  
    CloseWindow();
    UnloadSound(hitSound);   // Libère le son
        CloseAudioDevice();
    return (0);
    //gcc -Wall -Wextra -Werror -lraylib -lm -lpthread -ldl -lGL main.c -o main
}
