<?php
namespace Drupal\product_api\Controller;

use Drupal\Core\Controller\ControllerBase;
use GuzzleHttp\Client;

/**
 * Displays results from product API request.
 */
class ProductController extends ControllerBase {

  protected $guzzle;

  /**
   * ProductController constructor.
   */
  public function __construct() {
    $this->guzzle = new Client([
      'base_uri' => 'https://test-api.theinstitutes.org/product-api/v1/',
    ]);
  }

  /**
   * Display the content.
   *
   * @return array
   *   Return markup array.
   */
  public function content() {
    return [
      '#type' => 'markup',
      '#markup' => $this->programFindByCategory(['C']),
    ];
  }

  /**
   * Fetch programs by category.
   *
   * @param array $categories
   *   List of categories to fetch.
   *
   * @return string
   *   Response body text.
   */
  public function programFindByCategory(array $categories) {
    $response = $this->guzzle->get('program/findByCategory', [
      'auth' => ['ti_api', 'ti4#Life'],
      'query' => [
        'categories' => implode(',', $categories),
      ],
    ]);

    if ($response->getStatusCode() != 200) {
      var_dump($response);
      die();
    }

    return $response->getBody()->getContents();
  }

}
