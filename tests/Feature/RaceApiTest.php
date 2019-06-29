<?php

namespace Tests\Feature\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Foundation\Testing\RefreshDatabase;

class RaceApiTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function testRaceApi()
    {
        for ($i=1; $i<=8; $i++) {
            $response = $this->get('/api/race/'.$i);
            $response->assertStatus(200)->assertExactJson(
                $this->getStructure($i)
            );
        }
    }

    public function testMissingRace()
    {
        $response = $this->get('/api/race/123');

        $response->assertStatus(404);
    }

    protected function getStructure($id)
    {
        $race = \DB::table('races')->where('id', $id)->first();
        $a = ['runners' => [], 'name' => $race->name, 'number' => $race->number, 'distance' => $race->distance, 'meeting' => $race->meeting_name, 'status' => \DB::table('race_status')->where('id', $race->status_id)->first()->name];

        $runners = \DB::table('runners')->where('race_id', $id)->get();

        foreach ($runners as $runner) {
            $a['runners'][] = ['name' => $runner->name, 'number' => $runner->number, 'status' => \DB::table('runner_status')->where('id', $runner->status_id)->first()->name];
        }

        return $a;
    }
}
